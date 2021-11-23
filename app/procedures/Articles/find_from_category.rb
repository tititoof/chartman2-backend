# frozen_string_literal: true

module Articles
  # Find articles from category
  class FindFromCategory < ApplicationCallable
    attr_reader :category_id

    def initialize(category_id)
      @category_id = category_id
    end

    def execute
      category = Category.find(@category_id)

      articles = Post.from_category(category)

      OpenStruct.new({ success?: true, payload: articles, status: :ok })
    rescue ActiveRecord::RecordNotFound => invalid
      OpenStruct.new({ success?: false, errors: invalid.record.errors, status: ActiveRecord::RecordNotFound })
    end
  end
end