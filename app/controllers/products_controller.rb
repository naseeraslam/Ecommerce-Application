# frozen_string_literal: true

# This shiny device polishes bared foos
class ProductsController < ApplicationController
  before_action :set_product

  def index
    if current_user
      @products = current_user.products
      authorize @products
    else
      flash.alert = 'Please Login Yourself to create products'
      redirect_to new_user_session_path
    end
  end

  def create
    @product = current_user.products.new(product_params)
    authorize @product
    if @product.save
      flash[:notice] = 'Product added!'
      redirect_to product_path(@product)
    else
      flash[:errors] = @product.errors.full_messages
      render :new
    end
  end

  def update
    authorize @product
    if @product.update(product_params)
      flash[:notice] = 'Product updated!'
      redirect_to product_path(@product)
    else
      flash[:errors] = @product.errors.full_messages
      render :edit
    end
  end

  def destroy
    authorize @product
    if @product.destroy
      flash[:notice] = 'Product deleted!'
      redirect_to products_path
    else
      flash[:errors] = @product.errors.full_messages
      render :index
    end
  end

  private

  def product_params
    params.require(:product).permit(:product_name, :product_price, :product_description, :product_serial_number,
                                    :quantity, images: [])
  end

  def set_product
    @product = Product.find_by(id: params[:id])
  end
end
