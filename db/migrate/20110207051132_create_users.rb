class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users, :options => "AUTO_INCREMENT = 100000000" do |t|
      t.string :userid, :null => false
      t.string :hashed_password, :null => true
      t.string :old_hashed_password, :null => true
      t.string :salt, :null => false
      t.string :nick, :null => false
      t.string :email, :null => false
      t.string :title, :null => true
      t.string :intro, :null => true
      t.integer :post_count, :null => false, :default => 0
      t.integer :tag_count, :default => 0
      t.integer :store_count, :default => 0
      t.integer :following_count, :default => 0
      t.integer :follower_count, :default => 0
      t.integer :sequence, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
