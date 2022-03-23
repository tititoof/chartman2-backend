# frozen_string_literal: true

# Inspired by http://www.madebyloren.com/posts/migrating-to-uuids-as-primary-keys

task id_to_uuid: :environment do
  puts '[START] Convert id to uuid'
  unless ActiveRecord::Base.connection.extensions.include? 'uuid-ossp'
    ActiveRecord::Base.connection.enable_extension 'uuid-ossp'
  end
  unless ActiveRecord::Base.connection.extensions.include? 'pgcrypto'
    ActiveRecord::Base.connection.enable_extension 'pgcrypto'
  end

  table_names = ActiveRecord::Base.connection.tables - %w[schema_migrations ar_internal_metadata
                                                          migration_validators]
  table_names.each do |table_name|
    puts "[CREATE] uuid column for #{table_name}"

    # Make sure the column is a uuid if not delete it and then create it
    if ActiveRecord::Migration.column_exists? table_name, :uuid
      column_type = ActiveRecord::Migration.columns(table_name).select do |c|
        c.name == 'uuid'
      end.try(:first).try(:sql_type_metadata).try(:type)
      ActiveRecord::Migration.remove_column(table_name, :uuid) if column_type && column_type != :uuid
    end

    # Create it if it doesn't exist
    unless ActiveRecord::Migration.column_exists? table_name, :uuid
      ActiveRecord::Migration.add_column table_name, :uuid, :uuid, default: 'uuid_generate_v4()', null: false
    end
  end

  # The strategy here has three steps.
  # For each association:
  # 1) write the association's uuid to a temporary foreign key _uuid column,
  # 2) For each association set the value of the _uuid column
  # 3) remove the _id column and
  # 4) rename the _uuid column to _id, effectively migrating our foreign keys to UUIDs while sticking with the _id convention.
  table_names.each do |table_name|
    puts "[UPDATE] change id to uuid #{table_name}"
    model = table_name.singularize.camelize.constantize
    id_columns = model.column_names.select { |c| c.end_with?('_id') }

    # write the association's uuid to a temporary foreign key _uuid column
    # eg. Message.room_id => Message.room_uuid
    model.reflections.each do |_k, v|
      association_id_col = v.foreign_key
      # Error checking
      # Make sure the relationship actually currently exists
      next unless id_columns.include?(association_id_col)

      # Check that there is at

      # 1) Create temporary _uuid column set to nulll,
      tmp_uuid_column_name = column_name_to_uuid(association_id_col)
      unless ActiveRecord::Migration.column_exists?(table_name, tmp_uuid_column_name)
        puts "[CREATE] #{table_name}.#{tmp_uuid_column_name}"
        ActiveRecord::Migration.add_column(table_name, tmp_uuid_column_name, :uuid)
      end

      # 2) For each association set the value of the _uuid column
      #
      # For example.  Assume the following example
      #
      # message.room_id = 1
      # room = Room.find(1)
      # room.uuid = 0x123
      # message.room_uuid = 0x123
      #
      association_klass = v.klass

      model.unscoped.all.each do |inst|
        next unless inst.present?

        association = association_klass.find_by(id: inst.try(association_id_col.try(:to_sym)))
        next unless association.present?

        inst.update_column(tmp_uuid_column_name, association.try(:uuid))
      end

      # 3) Remove id column
      ActiveRecord::Migration.remove_column table_name, association_id_col if ActiveRecord::Migration.column_exists?(
        table_name, association_id_col
      )

      # 4) Rename uuid_col_name to id
      ActiveRecord::Migration.rename_column table_name, tmp_uuid_column_name, association_id_col
    rescue StandardError => e
      puts "Error: #{e} continuing"
      next
    end

    # Make each temp _uuid column linked up
    # eg. Message.find(1).room_uuid = Message.find(1).room.uuid
    puts "[UPDATE] #{model}.uuid to association uuid"
  end

  ## Migrate primary keys to uuids
  table_names.each do |table_name|
    next unless ActiveRecord::Migration.column_exists?(table_name,
                                                       :id) && ActiveRecord::Migration.column_exists?(table_name, :uuid)

    begin
      ActiveRecord::Base.connection.execute %(ALTER TABLE #{table_name} DROP CONSTRAINT #{table_name}_pkey CASCADE)
    rescue StandardError
      nil
    end
    ActiveRecord::Migration.remove_column(table_name, :id)
    ActiveRecord::Migration.rename_column(table_name, :uuid, :id) if ActiveRecord::Migration.column_exists?(
      table_name, :uuid
    )
    ActiveRecord::Base.connection.execute "ALTER TABLE #{table_name} ADD PRIMARY KEY (id)"
    begin
      ActiveRecord::Base.connection.execute %(DROP SEQUENCE IF EXISTS #{table_name}_id_seq CASCADE)
    rescue StandardError
      nil
    end
  end
end

# Add uuid to the id
# EG. column_name_to_uuid("room_id") => "room_uuid"
# EG. column_name_to_uuid("room_ids") => "room_uuids"
def column_name_to_uuid(column_name)
  *a, b = column_name.split('_id', -1)
  "#{a.join('_id')}_uuid#{b}"
end
