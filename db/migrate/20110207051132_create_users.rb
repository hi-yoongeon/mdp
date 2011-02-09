class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :userid
      t.string :hashed_password
      t.string :nick
      t.string :email
      t.string :salt

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
