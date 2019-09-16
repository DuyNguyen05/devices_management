# frozen_string_literal: true

class AddExpireToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :expires, :string
  end
end
