class CreateStoreDetailInfoLogs < ActiveRecord::Migration
  def self.up
    create_table :store_detail_info_logs do |t|
      t.integer :store_id, :null => false
      t.integer :user_id, :null => false
      t.string :status, :null => false
      t.integer :sequence, :null => false, :default => 0
      
      t.timestamps
    end
  end

  def self.down
    drop_table :store_detail_info_logs
  end
end
