class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.integer :sent_user_id
      t.integer :received_user_id
      t.text :message
      t.integer :sequence

      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end
