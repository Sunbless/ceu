class AddCenterToCases < ActiveRecord::Migration
  def change
    change_table :cases do |t|
      t.integer :center_id
    end
  end
end
