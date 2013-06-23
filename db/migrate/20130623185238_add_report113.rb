class AddReport113 < ActiveRecord::Migration
  def change
    create_table :report113, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
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
      t.float :col13, :default => 0
      t.float :col14, :default => 0
      t.float :col15, :default => 0
      t.float :col16, :default => 0
      t.float :col17, :default => 0
      t.float :col18, :default => 0
      t.float :col19, :default => 0
      t.float :col20, :default => 0
      t.float :col21, :default => 0
      t.float :col22, :default => 0
      t.float :col23, :default => 0
      t.float :col24, :default => 0
      t.float :col25, :default => 0
      t.float :col26, :default => 0
      t.float :col27, :default => 0
      t.float :col28, :default => 0
      t.float :col29, :default => 0
      t.float :col30, :default => 0

      t.timestamps
    end
  end
end
