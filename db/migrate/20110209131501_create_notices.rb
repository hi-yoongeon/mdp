class CreateNotices < ActiveRecord::Migration
  def self.up
    create_table :notices do |t|
      t.string :subject
      t.text :content
      t.string :target
      t.datetime :start_date
      t.datetime :end_date
      t.integer :sequence


      t.timestamps
    end
  end

  def self.down
    drop_table :notices
  end
end
