class CreateDeleteRequestedStoreFoods < ActiveRecord::Migration
  def self.up
    create_table :delete_requested_store_foods do |t|
      t.integer :user_id , :null => false
      t.integer :store_food_id, :null => false
      t.integer :sequence, :default => 0
      
      t.timestamps
    end
  end

  def self.down
    drop_table :delete_requested_store_foods
  end
end
