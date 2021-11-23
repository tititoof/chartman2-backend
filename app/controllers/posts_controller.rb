# frozen_string_literal: true

# Manage posts
class PostsController < ApplicationController
  before_action :authenticate_user!

  # list posts
  def index
    @post = OpenStruct.new({ success?: true, payload: Post.all, status: :ok })
    
    render_json
  end

  # create post
  def create
    @post = Posts::PostCreate.call(
      posts_params[:title],
      posts_params[:description],
      posts_params[:content],
      posts_params[:categories],
      current_user
    )

    render_json
  end

  # show post
  def show
    @post = Posts::PostFind.call(params[:id])

    render_json
  end

  # update post
  def update
    @post = Posts::PostUpdate.call(
      current_user, {
        id: params[:id],
        title: posts_params[:title],
        description: posts_params[:description],
        content: posts_params[:content],
        categories: posts_params[:categories]
      }
    )

    render_json
  end

  # destroy post
  def destroy
    @post = Posts::PostDestroy.call(params[:id])
    
    render_json
  end

  private

  # render json or errors
  def render_json
    if @post.success?
      render json: PostSerializer.new(@post.payload)
    else
      render json: @post.errors, status: :precondition_failed
    end
  end

  # params permitted
  def posts_params
    params.require(:post).permit(
      :id,
      :title,
      :description,
      :content,
      :user_id,
      categories: []
    )
  end
end
