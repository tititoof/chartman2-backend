# frozen_string_literal: true

# Update a post
class PostUpdater
  attr_reader :title, :description, :content, :categories_ids, :user

  def initialize(post_id, title, description, content, categories_ids, user)
    @post_id = post_id
    @title = title
    @description = description
    @content = content
    @categories_ids = categories_ids
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
