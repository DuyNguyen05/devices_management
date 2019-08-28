# frozen_string_literal: true

class CreateDevices < ActiveRecord::Migration[5.2]
  def change
    create_table :devices do |t|
      t.string :name
      t.string :code

      t.timestamps
    end
  end
end
