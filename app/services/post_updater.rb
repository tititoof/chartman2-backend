# frozen_string_literal: true

# Update a post
class PostUpdater
  attr_reader :post_id, :title, :content, :user

  def initialize(post_id, title, content, user_id)
    @post_id = post_id
    @title = title
    @content = content
    @user = User.find(user_id)
  end

  def execute
    post = Post.find(@post_id)
    post.update(title: @title, content: @content, user: @user)
    post.save
    post
  end
end
