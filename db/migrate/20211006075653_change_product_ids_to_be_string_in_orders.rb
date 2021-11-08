# frozen_string_literal: true

class ChangeProductIdsToBeStringInOrders < ActiveRecord::Migration[5.2]
  def change
    # change_column :orders, :product_ids, :string, null: false, array: true
  end
end
