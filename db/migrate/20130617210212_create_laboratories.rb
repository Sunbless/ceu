class CreateLaboratories < ActiveRecord::Migration
  def change
    create_table :laboratories, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :name
      t.string :uid
      t.integer :municipality_id
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
