# frozen_string_literal: true

module Categories
  # Desstroy a category
  class CategoryDestroy < ApplicationCallable
    attr_reader :id

    def initialize(id)
      @id = id
    end

    def execute
      category = Category.find(@id)

      category.destroy!

      OpenStruct.new({ success?: true, payload: category, status: :ok })
    rescue ActiveRecord::RecordNotFound => e
      OpenStruct.new({ success?: false, errors: e.record.errors, status: ActiveRecord::RecordNotFound })
    end
  end
end
