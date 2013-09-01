class AddUidToCases < ActiveRecord::Migration
  def change
    change_table :cases do |t|
      t.string :uid
    end
  end
end
