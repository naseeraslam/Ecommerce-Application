# frozen_string_literal: true

# This shiny device polishes bared foos
class CommentsController < ApplicationController
  before_action :set_product, only: %i[create destroy update]
  before_action :set_product_comment, only: %i[update]
  before_action :do_authorization, only: %i[update destroy]
  before_action :authenticate_user!

  def create
    @comment = @product.comments.new(comment_params)
    authorize @comment
    if @comment.save
      flash.now[:message] = 'Commented'
    else
      flash[:errors] = 'Comment unable to create'
      render :dashboard
    end
  end

  def update
    do_authorization
    if @comment.update(comment_params)
      flash[:notice] = 'Comment updated!'
      redirect_to dashboard_path(@comment.product_id)
    else
      flash[:errors] = @product.errors.full_messages
      render :edit
    end
  end

  def destroy
    do_authorization
    redirect_to request.referer || dashboard_path(@comment.product_id) if set_product_comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:feedback, :product_id).with_defaults(user_id: current_user.id)
  end

  def set_product
    @product = Product.find(params[:product_id])
  end

  def do_authorization
    set_comment
    authorize @comment
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_product_comment
    @comment = @product.comments.find(params[:id])
  end
end
