class CreateReport111 < ActiveRecord::Migration
  def change
    create_table :report111, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :name
      t.string :item_id
      t.float :col1, :default => 0
      t.float :col2, :default => 0
      t.float :col3, :default => 0
      t.float :col4, :default => 0
      t.float :col5, :default => 0
      t.float :col6, :default => 0
      t.float :col7, :default => 0
      t.float :col8, :default => 0
      t.float :col9, :default => 0
      t.float :col10, :default => 0
      t.float :col11, :default => 0
      t.float :col12, :default => 0

      t.timestamps
    end
  end
end
