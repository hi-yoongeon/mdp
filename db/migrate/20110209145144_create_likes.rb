class CreateLikes < ActiveRecord::Migration
  def self.up
    create_table :likes do |t|
      t.integer :user_id, :null => false
      t.integer :foreign_key, :null => false
      # store, post, store_food, food
      t.integer :sequence
      
      t.timestamps
    end
  end
  
  def self.down
    drop_table :likes
  end
end
