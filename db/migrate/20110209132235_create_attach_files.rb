class CreateAttachFiles < ActiveRecord::Migration
  def self.up
    create_table :attach_files do |t|
      t.integer :user_id, :null => false
      t.integer :store_id, :null => true
      t.integer :post_id, :null => false
      t.string :fullpath, :null => false
      t.string :webpath, :null => false
      t.integer :sequence

      t.timestamps
    end
  end

  def self.down
    drop_table :attach_files
  end
end
