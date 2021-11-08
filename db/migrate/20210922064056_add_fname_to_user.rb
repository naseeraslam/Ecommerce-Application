# frozen_string_literal: true

class AddFnameToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_name, :string, null: false, default: ''
  end
end
