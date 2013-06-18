class AddUserFields < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :name
      t.string :surname
      t.string :uid
      t.integer :user_type
      t.string :street
      t.string :post
      t.integer :municipality_id
      t.string :phone
      t.string :specialist
    end
  end

end
