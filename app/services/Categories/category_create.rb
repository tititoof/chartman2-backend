# frozen_string_literal: true

module Categories
  # Create Category
  class CategoryCreate < ApplicationCallable
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def execute
      category = Category.new(name: @name)

      category.save!

      OpenStruct.new({ success?: true, payload: category, status: :ok })
    rescue ActiveRecord::RecordInvalid => invalid
      OpenStruct.new({ success?: false, errors: invalid.record.errors, status: ActiveRecord::RecordInvalid })
    end
  end
end
