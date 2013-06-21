class AddDistrictAndUsernameToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :username
      t.integer :district_id
    end
  end
end
