class ChangeLikings < ActiveRecord::Migration[7.0]
  def change
    remove_index :likings, :post_id
    rename_column :likings, :post_id, :liked_id
    add_column :likings, :kind, :string
  end
end
