class CreateUserMileages < ActiveRecord::Migration
  def self.up
    create_table :user_mileages do |t|
      t.integer :user_id
      t.integer :total_point
      t.string :grade
      t.boolean :special_user
      t.boolean :blacklist_user

      t.timestamps
    end
  end

  def self.down
    drop_table :user_mileages
  end
end
