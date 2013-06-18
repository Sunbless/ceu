class CreateCenters < ActiveRecord::Migration
  def change
    create_table :centers, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :name
      t.string :code
      t.string :uid
      t.integer :municipality_id

      t.timestamps
    end
  end
end
