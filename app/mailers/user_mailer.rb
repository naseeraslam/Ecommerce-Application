# frozen_string_literal: true

# This shiny device polishes bared foos
class UserMailer < ApplicationMailer
  default from: 'naseer.aslam@devsinc.com'

  def registration_confirmation(user)
    @user = user
    mail(to: user.email, subject: 'Registered')
  end
end
