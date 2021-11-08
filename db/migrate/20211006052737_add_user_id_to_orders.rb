# frozen_string_literal: true

class AddUserIdToOrders < ActiveRecord::Migration[5.2]
  def change
    add_reference :orders, :user, null: false, foreign_key: true, default: 0
  end
end
