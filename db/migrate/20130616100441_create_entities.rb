class CreateEntities < ActiveRecord::Migration
  def change
    create_table :entities, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :description
      t.string :description_eng
      t.string :abbr

      t.timestamps
    end
  end
end
