class ChangeFrienships < ActiveRecord::Migration[7.0]
  def change
    rename_column :friendships, :friend_a_id, :friend1_id
    rename_column :friendships, :friend_b_id, :friend2_id
  end
end
