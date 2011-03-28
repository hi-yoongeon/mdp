class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users, :options => "AUTO_INCREMENT = 100000000" do |t|
      t.string :userid, :null => false
      t.string :hashed_password, :null => true
      t.string :old_hashed_password, :null => true
      t.string :nick, :null => false
      t.string :email, :null => false
      t.string :salt, :null => false
      t.integer :sequence

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
