class CreateBuyRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :buy_requests do |t|
      t.string :device_name
      t.text :reference_link
      t.text :reason
      t.integer :state, null: false, default: 0
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
