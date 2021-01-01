# frozen_string_literal: true

# Show articles
class ArticlesController < ApplicationController
  def index
    render json: PostSerializer.new(Post.from_category(Category.find(articles_params[:category_id])))
  end

  private

  def articles_params
    params.permit(:category_id)
  end
end
