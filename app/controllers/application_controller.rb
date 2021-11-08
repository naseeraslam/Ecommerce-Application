# frozen_string_literal: true

# This shiny device polishes bared foos
class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery

  before_action :configure_permitted_parameter, if: :devise_controller?

  protected

  def configure_permitted_parameter
    keys = %i[avatar first_name last_name]
    devise_parameter_sanitizer.permit(:sign_up, keys: keys)
    devise_parameter_sanitizer.permit(:account_update, keys: keys)
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to(request.referer || root_path)
  end
end
