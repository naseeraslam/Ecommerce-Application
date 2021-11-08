# frozen_string_literal: true

module Dashboardable
  def initialize_session
    session[:cart] ||= []
  end

  def id_conversion
    params[:id].to_i
  end

  def load_cart
    @cart = Product.find(id_array)
  end

  def item_delete
    session[:cart].each do |item|
      session[:cart].delete(item) if item['id'] == id_conversion
    end
  end

  def id_array
    session[:cart].map do |item|
      @items = item['id']
    end
  end

  def id_quantities_array
    session[:cart].map do |item|
      item['quant']
    end
  end

  def item_quantity_update
    @quantities = id_quantities_array
  end

  def check_quantity(id_q)
    product = Product.find(id_q)
    @avaliable_quantity = product.quantity
  end

  def set_product
    @product = Product.find_by(id: params[:id])
  end
end
