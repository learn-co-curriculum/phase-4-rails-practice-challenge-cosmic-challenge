class CreateScientists < ActiveRecord::Migration[7.0]
  def change
    create_table :scientists do |t|
      t.string :name
      t.string :field_of_study
      t.string :avatar

      t.timestamps
    end
  end
end
