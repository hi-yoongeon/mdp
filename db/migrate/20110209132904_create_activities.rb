class CreateActivities < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
      t.integer :user_id
      t.integer :store_id
      t.integer :like_id
      t.integer :bookmark_id
      t.integer :sequence

      t.timestamps
    end
  end

  def self.down
    drop_table :activities
  end
end
