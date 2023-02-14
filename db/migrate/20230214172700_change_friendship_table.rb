class ChangeFriendshipTable < ActiveRecord::Migration[7.0]
  def change
    rename_column :friendships, :requestor_id, :friend_a_id
    rename_column :friendships, :requestee_id, :friend_b_id
  end
end
