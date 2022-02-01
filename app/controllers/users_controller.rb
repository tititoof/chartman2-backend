# frozen_string_literal: true

# Users management
class UsersController < ApplicationController
  # show user
  def show
    render json: UserSerializer.new(User.find(users_params[:id]))
  end

  private

  # params permitted
  def users_params
    params.permit(:id)
  end
end
