class CreateAlarms < ActiveRecord::Migration
  def self.up
    create_table :alarms do |t|
      t.integer :received_user_id, :null => false
      t.integer :sent_user_id, :null => false
      t.string :alarm_type, :null => false
      t.integer :sequence

      t.timestamps
    end
  end

  def self.down
    drop_table :alarms
  end
end
