# frozen_string_literal: true

# Manage categories
class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: PostSerializer.new(Post.all)
  end

  def create
    @post = PostCreator.new(
      posts_params[:title],
      posts_params[:description],
      posts_params[:content],
      posts_params[:categories],
      current_user
    ).execute
    render_json
  end

  def show
    render json: PostSerializer.new(Post.find(posts_params[:id]))
  end

  def update
    @post = PostUpdater.new(
      current_user, {
        id: posts_params[:id],
        title: posts_params[:title],
        description: posts_params[:description],
        content: posts_params[:content],
        categories: posts_params[:categories]
    }).execute
    render_json
  end

  def destroy
    render json: PostDestroyer.new(posts_params[:id]).execute
  end

  private

  def render_json
    if @post.valid?
      render json: PostSerializer.new(@post)
    else
      render json: @post.errors, status: :precondition_failed
    end
  end

  def posts_params
    params.permit(
      :id,
      :title,
      :description,
      :content,
      :user_id,
      categories: []
    )
  end
end
