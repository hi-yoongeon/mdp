class CreateStoreTags < ActiveRecord::Migration
  def self.up
    create_table :store_tags do |t|
      t.integer :tag_id, :null => false
      t.integer :store_id, :null => false
      t.integer :count, :null => false, :default => 0
      t.integer :sequence
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :store_tags
  end
end
