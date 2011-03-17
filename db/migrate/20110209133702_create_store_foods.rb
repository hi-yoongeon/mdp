class CreateStoreFoods < ActiveRecord::Migration
  def self.up
    create_table :store_foods do |t|
      t.integer :user_id, :null => false
      t.integer :food_id, :null => false
      t.integer :store_id, :null => false
      t.integer :like_count, :null => false, :default => 0
      t.boolean :blind, :null => false, :default => 0
      t.integer :sequence, :null => false, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :store_foods
  end
end
