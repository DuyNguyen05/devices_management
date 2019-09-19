class AddTagToRequests < ActiveRecord::Migration[5.2]
  def change
    add_reference :requests, :tag, foreign_key: true
  end
end
