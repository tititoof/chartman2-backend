# frozen_string_literal: true

# Manage categories
class PostsController < ApplicationController
  def index
    render json: PostSerializer.new(Post.all)
  end

  def create
    @post = PostCreator.new(posts_params[:title], posts_params[:content], posts_params[:user_id]).execute
    render_json
  end

  def show
    render json: PostSerializer.new(Post.find(posts_params[:id]))
  end

  def update
    @post = PostUpdater.new(posts_params[:id], posts_params[:title], posts_params[:content], posts_params[:user_id]).execute
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
    params.permit(:id, :title, :content, :user_id)
  end
end
