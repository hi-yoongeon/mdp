class CreateModifyRequestedStores < ActiveRecord::Migration
  def self.up
    create_table :modify_requested_stores do |t|
      t.integer :user_id, :null => false
      t.integer :store_id, :null => false
      t.string :name, :null => false
      t.string :tel, :null => true
      t.string :address, :null => false
      t.string :add_address, :null => true
      t.string :website, :null => true
      t.text :cover, :null => true
      t.double :lat, :default => -1
      t.double :lng, :default => -1
      t.integer :sequence, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :modify_requested_stores
  end
end
