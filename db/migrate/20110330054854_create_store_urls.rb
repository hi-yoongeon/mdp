class CreateStoreUrls < ActiveRecord::Migration
  def self.up
    create_table :store_urls do |t|
      t.integer :user_id, :null => false
      t.integer :store_id, :null => false
      t.string :url, :null => false
      t.integer :sequence, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :store_urls
  end
end
