class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.string :location
      t.string :birth_date

      t.timestamps
    end
  end
end
