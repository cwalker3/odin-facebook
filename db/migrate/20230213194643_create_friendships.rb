class CreateFriendships < ActiveRecord::Migration[7.0]
  def change
    create_table :friendships do |t|
      t.integer :requestor_id, null: false, foreign_key: true
      t.integer :requestee_id, null: false, foreign_key: true
      t.string :status, default: 'pending'

      t.timestamps
    end
  end
end
