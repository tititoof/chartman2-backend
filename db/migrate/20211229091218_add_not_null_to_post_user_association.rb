class AddNotNullToPostUserAssociation < ActiveRecord::Migration[6.1]
  def change
    change_column :posts, :user_id, :uuid, null: false
  end
end
