class CreateStores < ActiveRecord::Migration
  def self.up
    create_table :stores do |t|
      t.integer :user_id
      t.integer :region_id
      t.string :name
      t.string :tel
      t.string :address
      t.string :add_address
      t.string :website
      t.text :cover
      t.string :lat
      t.string :lng
      t.integer :bookmark_count
      t.integer :like_count
      t.integer :memo_count
      t.integer :image_count
      t.integer :sequence

      t.timestamps
    end
  end

  def self.down
    drop_table :stores
  end
end
