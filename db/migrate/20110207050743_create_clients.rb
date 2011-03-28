class CreateClients < ActiveRecord::Migration
  def self.up
    create_table :clients do |t|
      t.integer :user_id, :null => false
      t.string :application_name, :null => false
      t.string :client_id, :null => false
      t.string :client_secret, :null => false
      t.string :redirect_uri, :null => false
      t.integer :sequence, :null => false, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :clients
  end
end
