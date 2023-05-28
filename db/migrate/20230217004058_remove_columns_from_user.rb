class RemoveColumnsFromUser < ActiveRecord::Migration[7.0]
  def change
    change_table :users do |t|
      t.remove :first_name
      t.remove :last_name
      t.remove :birth_date
      t.remove :gender
    end
  end
end
