class CreateFoods < ActiveRecord::Migration
  def self.up
    create_table :foods do |t|
      t.string :name, :null => false
      t.integer :like_count, :null => false, :default => 0
      t.integer :sequence


      t.timestamps
    end
  end

  def self.down
    drop_table :foods
  end
end
