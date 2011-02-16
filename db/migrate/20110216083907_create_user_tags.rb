class CreateUserTags < ActiveRecord::Migration
  def self.up
    create_table :user_tags do |t|
      t.integer :id
      t.integer :tag_id
      t.integer :user_id
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
