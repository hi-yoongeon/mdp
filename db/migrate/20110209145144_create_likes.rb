class CreateLikes < ActiveRecord::Migration
  def self.up
    create_table :likes do |t|
      t.integer :store_id
      t.integer :post_id
      t.integer :food_id
      t.integer :store_food_id
      t.integer :sequence

      t.timestamps
    end
  end

  def self.down
    drop_table :likes
  end
end
