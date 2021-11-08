# frozen_string_literal: true

class AddQuantityToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :quantity, :integer, null: false, default: 100
  end
end
