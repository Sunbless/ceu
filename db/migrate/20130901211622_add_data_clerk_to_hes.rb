class AddDataClerkToHes < ActiveRecord::Migration
  def change
    change_table :hes do |t|
      t.integer :dataclerk_id
    end
  end
end
