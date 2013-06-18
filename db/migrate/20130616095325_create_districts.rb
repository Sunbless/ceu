class CreateDistricts < ActiveRecord::Migration
  def change
    create_table :districts, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.integer :code
      t.integer :code_stat
      t.string :abbr
      t.string :name_eng
      t.string :centar
      t.string :name
      t.integer :population
      t.integer :municipalities
      t.integer :entity_id

      t.timestamps
    end
  end
end
