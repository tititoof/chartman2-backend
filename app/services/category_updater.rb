# frozen_string_literal: true

# Update a category
class CategoryUpdater
  attr_reader :category_id, :name

  def initialize(category_id, name)
    @category_id = category_id
    @name = name
  end

  def execute
    @category = Category.find(@category_id)
    @category.update(name: @name)
    @category.save
    @category
  end
end
