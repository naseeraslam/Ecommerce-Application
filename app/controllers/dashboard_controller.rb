# frozen_string_literal: true

# This shiny device polishes bared foos
class DashboardController < ApplicationController
  include Dashboardable
  before_action :initialize_session
  before_action :id_conversion, :id_array, :item_delete, only: %i[add_to_cart remove_from_cart remove_item_cart]
  before_action :load_cart, only: %i[index cart]
  before_action :set_product, only: %i[show]
  before_action :id_quantities_array, :item_quantity_update, only: %i[cart set_quantity]

  def add_to_cart
    cart_item = { id: id_conversion, quant: 1 }
    session[:cart] << cart_item unless session[:cart].include?(cart_item)
    redirect_to dashboard_index_path
  end

  def remove_from_cart
    redirect_to dashboard_index_path if item_delete
  end

  def remove_item_cart
    redirect_to cart_dashboard_index_path if item_delete
  end

  def index
    @products = Product.all.order(:product_name).page(params[:page]).per(3)
  end

  def set_quantity
    check_quantity(params[:pd_id])
    session[:cart].each do |item|
      if item['id'] == params[:pd_id].to_i
        if params[:quant].to_i < @avaliable_quantity && params[:quant].to_i.positive?
          item['quant'] = params[:quant].to_i
        else
          flash[:alert] = 'Invalid quantity or out of stock!'
        end
      end
    end
    redirect_to cart_dashboard_index_path
  end

  def show
    set_product
    @comment = Comment.new
    @comments = @product.comments.order('created_at DESC')
  end

  def search
    @products = Product.where("product_name ILIKE '%#{params[:product_name_cont]}%'")
  end
end
