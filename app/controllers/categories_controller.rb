# frozen_string_literal: true

# Manage categories
class CategoriesController < ApplicationController
  before_action :authenticate_user!

  # list all categories
  def index
    @category = { success: true, payload: Category.all, status: :ok }

    render_json
  end

  # create a category with his name
  def create
    @category = Categories::CategoryCreate.call(categories_params[:name])

    render_json
  end

  # show a category
  def show
    @category = Categories::CategoryFind.call(params[:id])

    render_json
  end

  # update a category's name
  def update
    @category = Categories::CategoryUpdate.call(params[:id], categories_params[:name])

    render_json
  end

  # destroy a category
  def destroy
    @category = Categories::CategoryDestroy.call(params[:id])

    render_json
  end

  private

  # render json success with object serialized or object with error(s)
  def render_json
    if @category[:success]
      render json: CategorySerializer.new(@category[:payload])
    else
      render json: @category[:errors], status: :precondition_failed
    end
  end

  # params allowed
  def categories_params
    params.require(:category).permit(:id, :name)
  end
end
