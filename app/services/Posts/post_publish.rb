# frozen_string_literal: true

module Posts
  # Published a post
  class PostPublish < ApplicationCallable
    attr_reader :post_id, :publish

    def initialize(post_id, publish)
      @post_id = post_id
      @publish = publish
    end

    def execute
      post = Post.find(@post_id)

      post.published = @publish
      post.published_at = @publish ? Date.current : nil
      post.save!

      OpenStruct.new({ success?: true, payload: post, status: :ok })
    rescue ActiveRecord::RecordNotFound => e
      OpenStruct.new({ success?: false, errors: e.record.errors, status: ActiveRecord::RecordNotFound })
    rescue ActiveRecord::RecordInvalid => e
      OpenStruct.new({ success?: false, errors: e.record.errors, status: ActiveRecord::RecordInvalid })
    end
  end
end