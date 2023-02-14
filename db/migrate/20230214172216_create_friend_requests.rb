class CreateFriendRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :friend_requests do |t|
      t.integer :requestor_id, null: false, foreign_key: true
      t.integer :requestee_id, null: false, foreign_key: true

      t.timestamps
    end
  end
end
