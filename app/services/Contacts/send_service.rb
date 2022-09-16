# frozen_string_literal: true

module Contacts
  # Send email to administrator
  class SendService < ApplicationCallable
    def initialize(user, email, subject, body)
      @user = user
      @subject = subject
      @body = body
      @email = email
    end

    def execute
      binding.break
      UserMailer.with(user: @user, email: @email, subject: @subject, body: @body).contact_email.deliver_later

      { success: true, payload: :ok }
    rescue StandardError => e
      { success: false, errors: e.message }
    end

    # private

    # attr_reader :name, :subject, :body, :email
  end
end
