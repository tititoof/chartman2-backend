# frozen_string_literal: true

# Desstroy a post
class PostDestroyer
  attr_reader :post_id

  def initialize(post_id)
    @post_id = post_id
  end

  def execute
    post = Post.find(@post_id)
    post.destroy
  end
end
