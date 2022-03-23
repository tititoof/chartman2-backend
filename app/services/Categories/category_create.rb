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

      { success?: true, payload: category, status: :ok }
    rescue ActiveRecord::RecordInvalid => e
      { success?: false, errors: e.record.errors, status: ActiveRecord::RecordInvalid }
    end
  end
end
