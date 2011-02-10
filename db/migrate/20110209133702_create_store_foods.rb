class CreateStoreFoods < ActiveRecord::Migration
  def self.up
    create_table :store_foods do |t|
      t.integer :food_id
      t.integer :store_id
      t.string :food_name
      t.integer :sequence

      t.timestamps
    end
  end

  def self.down
    drop_table :store_foods
  end
end
