# frozen_string_literal: true

# Send email to administrator
class UserMailer < ApplicationMailer
  default from: 'no-reply@chartman2.fr'

  def contact_email
    @name = params[:name]
    @email = params[:email]
    @subject = params[:subject]
    @message = params[:message]

    mail(to: 'chartmann.35@gmail.com', subject: @subject)
  end
end
