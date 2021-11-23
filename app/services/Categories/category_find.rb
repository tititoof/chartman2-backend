# frozen_string_literal: true

module Categories
  # Create Category
  class CategoryFind < ApplicationCallable
    attr_reader :id

    def initialize(id)
      @id = id
    end

    def execute
      category = Category.find(@id)

      OpenStruct.new({ success?: true, payload: category, status: :ok })
    rescue ActiveRecord::RecordNotFound => invalid
      OpenStruct.new({ success?: false, errors: invalid.record.errors, status: ActiveRecord::RecordNotFound })
    end
  end
end
