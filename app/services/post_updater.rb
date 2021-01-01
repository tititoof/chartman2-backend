# frozen_string_literal: true

# Update a post
class PostUpdater
  attr_reader :title, :description, :content, :categories_ids, :user

  def initialize(user, params)
    @post_id = params[:id]
    @title = params[:title]
    @description = params[:description]
    @content = params[:content]
    @categories_ids = params[:categories_ids]
    @user = user
  end

  def execute
    @post = Post.find(@post_id)
    @post.update(title: @title, description: @description, content: @content, user: @user)

    PostCategoriesAdder.new(@post, @categories_ids).execute if @post.valid?

    @post.save
    @post
  end
end
