class CreateDeleteRequestedStores < ActiveRecord::Migration
  def self.up
    create_table :delete_requested_stores do |t|
      t.integer :user_id, :null => false
      t.integer :store_id, :null => false
      t.integer :sequence, :default => 0
      
      t.timestamps
    end
  end

  def self.down
    drop_table :delete_requested_stores
  end
end
