# frozen_string_literal: true

# This shiny device polishes bared foos
class CheckoutController < ApplicationController
  include Checkoutable
  before_action :stripe_setting, :stripe_helper, only: %i[create]
  before_action :set_order, only: %i[success]
  after_action :order_insertion, :order_params, :quantity_update, only: %i[create]

  def create
    if user_signed_in?
      stripe_setting
    else
      flash.alert = 'Please Login Yourself to purchase products'
      redirect_to new_user_session_path
    end
  end

  def success
    session[:cart] = []
  end
end
