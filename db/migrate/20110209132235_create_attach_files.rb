class CreateAttachFiles < ActiveRecord::Migration
  def self.up
    create_table :attach_files do |t|
      t.integer :user_id
      t.integer :store_id
      t.integer :post_id
      t.string :filename
      t.string :webpath
      t.integer :sequence

      t.timestamps
    end
  end

  def self.down
    drop_table :attach_files
  end
end
