class CreateActivities < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
      t.integer :user_id, :null => false
      t.integer :foreign_key, :null => false
      t.string :type, :null => false # store, like, bookmark
      t.integer :sequence

      t.timestamps
    end
  end

  def self.down
    drop_table :activities
  end
end
