class ChangeLikings < ActiveRecord::Migration[7.0]
  def change
    drop_table :likings
 
  end
end
