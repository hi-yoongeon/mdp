class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.integer :user_id, :null => false
      t.integer :parent_post_id, :null => true
      t.integer :store_id, :null => true
      t.integer :activity_id, :null => true
      t.text :post, :null => false
      t.integer :image_count, :null => false, :default => 0
      t.integer :sequence

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
