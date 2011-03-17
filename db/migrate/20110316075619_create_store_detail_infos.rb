class CreateStoreDetailInfos < ActiveRecord::Migration
  def self.up
    create_table :store_detail_infos do |t|
      t.integer :user_id, :null => false
      t.integer :store_id, :null => false
      t.string :note , :null => true
      t.integer :sequence, :null => false, :default => 0
      
      t.timestamps
    end
  end

  def self.down
    drop_table :store_detail_infos
  end
end
