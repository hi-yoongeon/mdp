class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.integer :user_id
      t.integer :store_id
      t.integer :activities_id
      t.text :post
      t.integer :image_count
      t.integer :sequence

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
