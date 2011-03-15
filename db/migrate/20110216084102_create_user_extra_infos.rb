class CreateUserExtraInfos < ActiveRecord::Migration
  def self.up
    create_table :user_extra_infos do |t|
      t.integer :id
      t.integer :user_id
      t.string :title
      t.string :intro
      t.integer :post_count
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
