class AddPhiToCenter < ActiveRecord::Migration
  def change
    change_table :centers do |t|
      t.integer :phi_id
    end
  end
end
