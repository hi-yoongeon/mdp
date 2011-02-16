class CreateStores < ActiveRecord::Migration
  def self.up
    create_table :stores do |t|
      t.string :name, :null => false
      t.integer :reg_user_id, :null => false
      t.string :tel, :null => true
      t.string :address, :null => false
      t.string :add_address, :null => true
      t.string :website, :null => true
      t.text :cover, :null => true
      t.float :lat, :null => false, :default => 0
      t.float :lng, :null => false, :default => 0
      t.integer :bookmark_count, :null => false, :default => 0 
      t.integer :like_count, :null => false, :default => 0
      t.integer :memo_count, :null => false, :default => 0
      t.integer :image_count, :null => false, :default => 0
      t.integer :sequence

      t.timestamps
    end
  end

  def self.down
    drop_table :stores
  end
end
