# frozen_string_literal: true

# Desstroy a category
class CategoryDestroyer
  attr_reader :category_id

  def initialize(category_id)
    @category_id = category_id
  end

  def execute
    category = Category.find(@category_id)
    category.destroy
  end
end
