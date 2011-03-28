class CreateUserExtraInfos < ActiveRecord::Migration
  def self.up
    create_table :user_extra_infos do |t|
      t.integer :id, :null => false
      t.integer :user_id, :null => false
      t.string :title, :null => true
      t.string :intro, :null => true
      t.integer :post_count, :null => false, :default => 0
      t.integer :sequence
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :user_extra_infos
  end
end
