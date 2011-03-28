class CreateUserExternalAccounts < ActiveRecord::Migration
  def self.up
    create_table :user_external_accounts do |t|
      t.integer :id, :null => false
      t.integer :user_id, :null => false
      t.string :service, :null => false
      # facebook, twitter
      t.text :data, :null => false
      t.integer :sequence
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :user_external_accounts
  end
end
