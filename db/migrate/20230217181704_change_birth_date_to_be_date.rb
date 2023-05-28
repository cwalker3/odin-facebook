class ChangeBirthDateToBeDate < ActiveRecord::Migration[7.0]
  def change
    remove_column :profiles, :birth_date
    add_column :profiles, :birth_date, :date
  end
end
