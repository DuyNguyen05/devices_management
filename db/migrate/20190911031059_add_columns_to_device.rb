class AddColumnsToDevice < ActiveRecord::Migration[5.2]
  def change
    add_column :devices, :accquired_date, :datetime
    add_column :devices, :supplier, :string
    add_reference :devices, :user, index: true
    add_column :devices, :price, :float
    add_column :devices, :condition, :integer, default: 0
  end
end
