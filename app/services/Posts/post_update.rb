# frozen_string_literal: true

module Posts
  # Update a post
  class PostUpdate < ApplicationCallable
    attr_reader :title, :description, :content, :categories_ids, :user

    def initialize(user, params)
      @post_id = params[:id]
      @title = params[:title]
      @description = params[:description]
      @content = params[:content]
      @categories_ids = params[:categories]
      @user = user
    end

    def execute
      post = Post.find(@post_id)

      post.update(title: @title, description: @description, content: @content, user: @user)
      Articles::ArticlesAdd.call(post, @categories_ids) if post.valid?

      post.save!

      { success?: true, payload: post, status: :ok }
    rescue ActiveRecord::RecordInvalid => e
      { success?: false, errors: e.record.errors, status: ActiveRecord::RecordInvalid }
    rescue ActiveRecord::RecordNotFound => e
      { success?: false, errors: e.record.errors, status: ActiveRecord::RecordNotFound }
    end
  end
end
