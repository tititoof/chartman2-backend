# frozen_string_literal: true

# Create a post
class PostCreator
  attr_reader :title, :content, :user

  def initialize(title, content, user_id)
    @title = title
    @content = content
    @user = User.find(user_id)
  end

  def execute
    post = Post.create(title: @title, content: @content, user: @user)
    post.save
    post
  end
end
