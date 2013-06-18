class CreateIcds < ActiveRecord::Migration
  def change
    create_table :icds, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :code
      t.string :disease_bsn
      t.string :disease_eng
      t.integer :int
      t.integer :both

      t.timestamps
    end
  end
end
