# frozen_string_literal: true

class AddDescriptionFieldToPosts < ActiveRecord::Migration[6.0]
  def change
    change_table :users do |t|
      t.string :description, default: 'description', null: false
    end
  end
end
