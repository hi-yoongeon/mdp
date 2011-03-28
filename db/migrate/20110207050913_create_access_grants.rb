class CreateAccessGrants < ActiveRecord::Migration
  def self.up
    create_table :access_grants do |t|
      t.integer :user_id, :null => false
      t.integer :client_id, :null => false
      t.string :access_token , :null => false
      t.string :refresh_token # non use
      t.string :code # non use
      t.datetime :access_token_expires_at # non use
      t.integer :sequence, :null => false, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :access_grants
  end
end
