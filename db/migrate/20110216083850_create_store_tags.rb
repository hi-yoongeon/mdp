class CreateStoreTags < ActiveRecord::Migration
  def self.up
    create_table :store_tags do |t|
      t.integer :id
      t.integer :tag_id
      t.integer :store_id
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
