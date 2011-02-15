class CreateRegions < ActiveRecord::Migration
  def self.up
    create_table :regions do |t|
      #t.string :position, :null => false
      t.float :lat_sw, :null => false
      t.float :lng_sw, :null => false
      t.float :lat_ne, :null => false
      t.float :lng_ne, :null => false
      t.integer :sequence

      t.timestamps
    end
  end

  def self.down
    drop_table :regions
  end
end
