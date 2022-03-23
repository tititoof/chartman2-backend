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

      { success: true, payload: post, status: :ok }
    rescue ActiveRecord::RecordNotFound => _e
      { success: false, errors: 'record not found', status: ActiveRecord::RecordNotFound }
    end
  end
end
