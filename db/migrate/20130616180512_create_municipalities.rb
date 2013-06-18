class CreateMunicipalities < ActiveRecord::Migration
  def change
    create_table :municipalities, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :municipality
      t.integer :district_id

      t.timestamps
    end
  end
end
