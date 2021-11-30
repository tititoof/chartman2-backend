# frozen_string_literal: true

module Posts
  # Create Category
  class PostFind < ApplicationCallable
    attr_reader :id

    def initialize(id)
      @id = id
    end

    def execute
      post = Post.find(@id)

      OpenStruct.new({ success?: true, payload: post, status: :ok })
    rescue ActiveRecord::RecordNotFound => e
      OpenStruct.new({ success?: false, errors: e.record.errors, status: ActiveRecord::RecordNotFound })
    end
  end
end
