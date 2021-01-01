# frozen_string_literal: true

class AddAdminFieldToUsers < ActiveRecord::Migration[6.0]
  def change
    change_table :users do |t|
      t.boolean :admin, default: false, null: false
    end
  end
end
