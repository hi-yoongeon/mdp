class CreatePostComments < ActiveRecord::Migration
  def self.up
    create_table :post_comments do |t|
      t.integer :user_id, :null => false
      t.integer :post_id, :null => false
      t.string :comment, :null => false
      t.integer :sequence, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :post_comments
  end
end
