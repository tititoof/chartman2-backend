# frozen_string_literal: true

module Categories
  # Update a category
  class CategoryUpdate < ApplicationCallable
    attr_reader :id, :name

    def initialize(id, name)
      @id = id
      @name = name
    end

    def execute
      category = Category.find(@id)

      category.update!(name: @name)

      OpenStruct.new({ success?: true, payload: category, status: :ok })
    rescue ActiveRecord::RecordInvalid => e
      OpenStruct.new({ success?: false, errors: e.record.errors, status: ActiveRecord::RecordInvalid })
    end
  end
end
