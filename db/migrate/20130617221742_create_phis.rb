class CreatePhis < ActiveRecord::Migration
  def change
    create_table :phis do |t|
      t.string :abbrev
      t.string :address
      t.string :full_bsn
      t.string :full_eng
      t.string :mail_no
      t.integer :municipality_id
      t.string :phone
      t.string :fax
      t.string :epidemiologist
      t.string :email
      t.string :post
      t.integer :district_id

      t.timestamps
    end
  end
end
