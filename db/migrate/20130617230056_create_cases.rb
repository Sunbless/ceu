class CreateCases < ActiveRecord::Migration
  def change
    create_table :cases do |t|
      t.integer :district_id
      t.integer :phi_id
      t.integer :he_id
      t.integer :user_id
      t.string :protocol
      t.text :dg_syndrom
      t.date :date_of_dg
      t.integer :labconfirmed
      t.integer :laboratory_id
      t.date :date_lab
      t.integer :agent_id
      t.date :date_report
      t.date :date_entry
      t.integer :vaccin
      t.integer :operator_id
      t.text :comment
      t.string :patient_name
      t.string :patient_surname
      t.integer :age
      t.date :date_of_birth
      t.date :date_death
      t.string :sex
      t.string :jmbg

      t.timestamps
    end
  end
end
