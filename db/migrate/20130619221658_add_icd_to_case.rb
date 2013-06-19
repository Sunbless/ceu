class AddIcdToCase < ActiveRecord::Migration
  def change
    change_table :cases do |t|
      t.integer :icd_id
    end
  end
end
