class CreateHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :histories do |t|
      t.datetime :end_at
      t.references :user, foreign_key: true
      t.references :device, foreign_key: true

      t.timestamps
    end
  end
end
