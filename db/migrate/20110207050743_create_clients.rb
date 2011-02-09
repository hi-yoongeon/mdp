class CreateClients < ActiveRecord::Migration
  def self.up
    create_table :clients do |t|
      t.integer :user_id
      t.string :application_name
      t.string :client_id
      t.string :client_secret
      t.string :redirect_uri
      t.timestamps
    end
  end

  def self.down
    drop_table :clients
  end
end
