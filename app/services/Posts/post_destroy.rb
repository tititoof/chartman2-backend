# frozen_string_literal: true

module Posts
  # Desstroy a post
  class PostDestroy < ApplicationCallable
    attr_reader :post_id

    def initialize(post_id)
      @post_id = post_id
    end

    def execute
      post = Post.find(@post_id)
      
      post.articles.each(&:destroy)
      post.destroy

      OpenStruct.new({ success?: true, payload: post, status: :ok })
    rescue ActiveRecord::RecordNotFound => invalid
      OpenStruct.new({ success?: false, errors: invalid.record.errors, status: ActiveRecord::RecordNotFound })
    end
  end
end