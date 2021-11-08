# frozen_string_literal: true

module Checkoutable
  def quantity_update
    params[:product_ids].zip(params[:quantities_list]).each do |p, q|
      quantity_update_helper(p.to_i, q)
    end
  end

  def stripe_setting
    @session = Stripe::Checkout::Session.create({
                                                  payment_method_types: ['card'],
                                                  line_items: stripe_helper,
                                                  allow_promotion_codes: true,
                                                  mode: 'payment',
                                                  success_url: success_checkout_index_url,
                                                  cancel_url: cancel_checkout_index_url
                                                })
  end

  def stripe_helper
    [{
      name: params[:name_list].to_s,
      amount: (params[:total_price].to_i * 100),
      currency: 'usd',
      quantity: 1
    }]
  end

  def order_insertion
    @order = Order.new(order_params)
    if @order.save
      flash[:notice] = 'Order created!'
    else
      flash[:alert] = 'Order fail'
      redirect_to cart_dashboard_index_path
    end
  end

  def order_params
    params.permit(:customer_name, :user_id,
                  [product_ids: []]).with_defaults(total_price: (@session['amount_total'] / 100),
                                                   discount: @session['total_details']['amount_discount'])
  end

  def set_order
    @order_detail = Order.where(user_id: current_user.id).last
  end

  def quantity_update_helper(prod, quantity)
    quant = Product.find(prod)
    quant.update(quantity: quantity)
  end
end
