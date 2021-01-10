# frozen_string_literal: true

# Manage categories
class CategoriesController < ApplicationController
  before_action :authenticate_user!

  # list categories
  def index
    render json: CategorySerializer.new(Category.all)
  end

  # create a category
  def create
    @category = CategoryCreator.new(categories_params[:name]).execute
    render_json
  end

  # show a category
  def show
    render json: CategorySerializer.new(Category.find(categories_params[:id]))
  end

  # update a category
  def update
    @category = CategoryUpdater.new(categories_params[:id], categories_params[:name]).execute
    render_json
  end

  # destroy a category
  def destroy
    render json: CategoryDestroyer.new(categories_params[:id]).execute
  end

  private

  # render json success with object serialized or object with error(s)
  def render_json
    if @category.valid?
      render json: CategorySerializer.new(@category)
    else
      render json: @category.errors, status: :precondition_failed
    end
  end

  # params allowed
  def categories_params
    params.permit(:id, :name)
  end
end
