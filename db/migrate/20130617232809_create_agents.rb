class CreateAgents < ActiveRecord::Migration
  def change
    create_table :agents do |t|
      t.string :uid
      t.string :agent

      t.timestamps
    end
  end
end
