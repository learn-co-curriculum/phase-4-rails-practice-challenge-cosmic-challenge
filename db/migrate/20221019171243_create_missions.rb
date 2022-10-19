class CreateMissions < ActiveRecord::Migration[7.0]
  def change
    create_table :missions do |t|
      t.string :name
      t.integer :scientist_id
      t.integer :planet_id

      t.timestamps
    end
  end
end
