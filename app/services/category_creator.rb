# frozen_string_literal: true

# Create Category
class CategoryCreator
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def execute
    category = Category.new(name: @name)
    category.save
    category
  end
end
