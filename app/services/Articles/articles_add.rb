# frozen_string_literal: true

module Articles
  # Add categories to a post
  class ArticlesAdd < ApplicationCallable
    attr_reader :post, :categories_ids

    def initialize(post, categories_ids)
      @post = post
      @categories_ids = categories_ids
    end

    def execute
      return if @categories_ids.nil?

      categories = []

      @categories_ids.each do |category_id|
        category = Category.find(category_id)
        categories << category
      end

      @post.categories = categories
    end
  end
end