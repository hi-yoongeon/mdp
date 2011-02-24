class CreateUserTags < ActiveRecord::Migration
  def self.up
    create_table :user_tags do |t|
      t.integer :tag_id, :null => false
      t.integer :user_id, :null => false
      t.integer :count, :null => false, :default => 0
      t.integer :sequence
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :user_tags
  end
end
