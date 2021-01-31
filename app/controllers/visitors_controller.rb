# frozen_string_literal: true

# Show articles and categories
class VisitorsController < ApplicationController
  # show articles from a category
  def articles
    render json: PostSerializer.new(Post.from_category(Category.find(visitor_params[:category_id])))
  end

  # show an article
  def article
    render json: PostSerializer.new(Post.find(visitor_params[:article_id]))
  end

  # show categories
  def categories
    render json: CategorySerializer.new(Category.all)
  end

  # show a category
  def category
    render json: CategorySerializer.new(Category.find(visitor_params[:category_id]))
  end

  private

  # params permitted
  def visitor_params
    params.permit(:category_id, :article_id)
  end
end
