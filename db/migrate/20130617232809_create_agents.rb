class CreateAgents < ActiveRecord::Migration
  def change
    create_table :agents, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :uid
      t.string :agent

      t.timestamps
    end
  end
end
