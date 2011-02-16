class CreateActivities < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
      t.string :user_name, :null => false
      t.string :user_id, :null => false
      t.string :object_type, :null => false
      # user, post, store, storefood
      t.string :object_name, :null => false
      t.string :object_id, :null => false
      t.string :object_complement_type, :null => false, :default => "None"
      # none, post, store, storefood
      t.string :object_complement_name
      t.string :object_complement_id
      t.string :action, :null => false
      # like, store, bookmark

      t.integer :sequence

      t.timestamps
    end
  end

  def self.down
    drop_table :activities
  end
end
