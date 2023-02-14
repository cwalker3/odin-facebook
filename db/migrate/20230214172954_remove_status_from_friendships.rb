class RemoveStatusFromFriendships < ActiveRecord::Migration[7.0]
  def change
    remove_column :friendships, :status
  end
end
