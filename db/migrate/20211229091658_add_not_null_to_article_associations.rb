# frozen_string_literal: true

class AddNotNullToArticleAssociations < ActiveRecord::Migration[6.1]
  def change
    change_column :articles, :post_id, :uuid, null: false
    change_column :articles, :category_id, :uuid, null: false
  end
end
