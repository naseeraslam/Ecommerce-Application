# frozen_string_literal: true

class Order < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :customer_name, null: false
      t.string :product_ids, null: false, array: true
      t.integer :discount, null: false
      t.integer :total_price, null: false

      t.timestamps
    end
  end
end
