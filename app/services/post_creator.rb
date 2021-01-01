# frozen_string_literal: true

# Create a post
class PostCreator
  attr_reader :title, :description, :content, :categories_ids, :user

  def initialize(title, description, content, categories_ids, user)
    @title = title
    @description = description
    @content = content
    @categories_ids = categories_ids
    @user = user
  end

  def execute
    @post = Post.create(title: @title, description: @description, content: @content, user: @user)

    PostCategoriesAdder.new(@post, @categories_ids).execute if @post.valid?

    @post.save
    @post
  end
end
