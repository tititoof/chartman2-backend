# frozen_string_literal: true

class AddPublishedToPost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :published, :boolean
  end
end
