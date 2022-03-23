# frozen_string_literal: true

module Posts
  # Create a post
  class PostCreate < ApplicationCallable
    attr_reader :title, :description, :content, :categories_ids, :user

    def initialize(title, description, content, categories_ids, user)
      @title = title
      @description = description
      @content = content
      @categories_ids = categories_ids
      @user = user
    end

    def execute
      post = Post.create(title: @title, description: @description, content: @content, user: @user)
      Articles::ArticlesAdd.call(post, @categories_ids) if post.valid?

      post.save!

      { success: true, payload: post, status: :ok }
    rescue ActiveRecord::RecordInvalid => e
      { success: false, errors: 'invalid record', status: ActiveRecord::RecordInvalid }
    end
  end
end
