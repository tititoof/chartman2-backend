# frozen_string_literal: true

# Contacts management
class ContactsController < ApplicationController
  # send email
  def create
    UserMailer.with(
      name: contacts_params[:name],
      email: contacts_params[:email],
      subject: contacts_params[:subject],
      message: contacts_params[:message]
    ).contact_email.deliver_now
    # success = Contacts::SendService.new(
    #   contacts_params[:user],
    #   contacts_params[:email],
    #   contacts_params[:subject],
    #   contacts_params[:body]
    # ).execute

    render json: :ok
  end

  private

  # params permitted
  def contacts_params
    params.require(:contact).permit(:name, :email, :subject, :message)
  end
end
