class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.integer :user_id, :null => false
      t.integer :store_id, :null => true
      t.integer :activity_id, :null => true
      t.string :post, :null => false
      t.integer :image_count, :default => 0
      t.integer :like_count, :default => 0
      t.integer :comment_count, :default => 0
      t.integer :tag_count, :default => 0
      t.float :lat, :default => 0
      t.float :lng, :default => 0
      t.string :from_where, :null => false, :default => "IPHONE"
      t.integer :sequence

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
