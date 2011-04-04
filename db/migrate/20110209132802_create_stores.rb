class CreateStores < ActiveRecord::Migration
  def self.up
    create_table :stores do |t|
      t.string :name, :null => false
      t.integer :reg_user_id, :null => true
      t.string :tel, :null => true
      t.string :address, :null => false
      t.string :add_address, :null => true
      t.string :website, :null => true
      t.text :cover, :null => true
      t.float :lat, :default => 0
      t.float :lng, :default => 0
      t.integer :tag_count, :default => 0 
      t.integer :post_count, :default => 0
      t.integer :image_count, :default => 0
      t.integer :like_count, :default => 0
      t.integer :bookmark_count, :default => 0
      t.integer :sequence, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :stores
  end
end
