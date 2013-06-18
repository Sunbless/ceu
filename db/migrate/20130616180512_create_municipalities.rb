class CreateMunicipalities < ActiveRecord::Migration
  def change
    create_table :municipalities do |t|
      t.string :municipality
      t.integer :district_id

      t.timestamps
    end
  end
end
