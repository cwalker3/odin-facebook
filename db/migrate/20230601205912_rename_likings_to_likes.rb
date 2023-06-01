class RenameLikingsToLikes < ActiveRecord::Migration[7.0]
  def change
    rename_table :likings, :likes
  end
end
