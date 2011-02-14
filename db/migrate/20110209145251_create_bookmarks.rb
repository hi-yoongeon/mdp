class CreateBookmarks < ActiveRecord::Migration
  def self.up
    create_table :bookmarks do |t|
      t.integer :user_id, :null => false
      t.integer :foreign_key, :null => false
      # store, post, position
      t.integer :sequence

      t.timestamps
    end
  end

  def self.down
    drop_table :bookmarks
  end
end

