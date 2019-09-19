class CreateTagRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :tag_requests do |t|
      t.references :tag, foreign_key: true
      t.references :request, foreign_key: true

      t.timestamps
    end
  end
end
