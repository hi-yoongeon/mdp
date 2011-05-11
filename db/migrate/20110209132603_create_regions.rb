class CreateRegions < ActiveRecord::Migration
  def self.up
    create_table :regions do |t|
      t.integer :user_id, :null => false
      t.float :lat_sw, :null => false, :default => 0
      t.float :lng_sw, :null => false, :default => 0
      t.float :lat_ne, :null => false, :default => 0
      t.float :lng_ne, :null => false, :default => 0
      t.string :description, :null => false
      t.integer :sequence

      t.timestamps
    end
  end

  def self.down
    drop_table :regions
  end
end
