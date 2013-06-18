class CreateHes < ActiveRecord::Migration
  def change
    create_table :hes do |t|
      t.integer :center_id
      t.string :code
      t.string :name
      t.integer :chief_id
      t.integer :nurse_id
      t.string :uid

      t.timestamps
    end
  end
end
