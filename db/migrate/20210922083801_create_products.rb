# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :product_name, null: false, default: ''
      t.integer :product_price, null: false, default: 1
      t.text :product_description, null: false, length: { maximum: 500 }, default: ''
      t.string :product_serial_number, null: false, default: ''
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
