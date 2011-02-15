class CreateStoreFoods < ActiveRecord::Migration
  def self.up
    create_table :store_foods do |t|
      t.integer :food_id, :null => false
      t.integer :store_id, :null => false
      t.string :food_name, :null => false
      t.integer :like_count, :null => false, :default => 0
      t.integer :sequence

      t.timestamps
    end
  end

  def self.down
    drop_table :store_foods
  end
end
