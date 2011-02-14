class CreateNotices < ActiveRecord::Migration
  def self.up
    create_table :notices do |t|
      t.string :subject, :null => false
      t.text :content, :null => false
      t.string :target, :null => false
      t.datetime :start_date, :null => false
      t.datetime :end_date, :null => false
      t.integer :sequence


      t.timestamps
    end
  end

  def self.down
    drop_table :notices
  end
end
