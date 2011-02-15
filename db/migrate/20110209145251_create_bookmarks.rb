class CreateBookmarks < ActiveRecord::Migration
  def self.up
    create_table :bookmarks do |t|
      t.integer :user_id, :null => false
      t.integer :foreign_key, :null => false
      t.string :type, :null => false # store, post, region
      t.integer :sequence

      t.timestamps
    end
  end

  def self.down
    drop_table :bookmarks
  end
end

