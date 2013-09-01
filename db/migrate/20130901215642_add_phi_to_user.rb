class AddPhiToUser < ActiveRecord::Migration

  def change
    change_table :users do |t|
      t.integer :phi_id
    end
  end

end
