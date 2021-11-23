# frozen_string_literal: true

# Show articles and categories
class VisitorsController < ApplicationController
  # show articles from a category
  def articles
    @data = Articles::FindFromCategory.call(visitor_params[:category_id])

    render_json PostSerializer
  end

  # show an article
  def article
    @data = Posts::PostFind.call(visitor_params[:article_id])

    render_json PostSerializer
  end

  # show categories
  def categories
    @data = OpenStruct.new({ success?: true, payload: Category.all, status: :ok })

    render_json CategorySerializer
  end

  # show a category
  def category
    @data = Categories::CategoryFind.call(visitor_params[:category_id])

    render_json CategorySerializer
  end

  private

  def render_json(serializer)
    if @data.success?
      render json: serializer.new(@data.payload)
    else
      render json: @data.errors, status: :precondition_failed
    end
  end

  # params permitted
  def visitor_params
    params.permit(:category_id, :article_id)
  end
end
