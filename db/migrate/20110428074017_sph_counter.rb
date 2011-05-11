class SphCounter < ActiveRecord::Migration
  def self.up
    create_table :sph_store_counter do |t|
      t.integer :max_id, :null => false
    end
    create_table :sph_post_counter do |t|
      t.integer :max_id, :null => false
    end
  end

  def self.down
    drop_table :sph_store_counter
    drop_table :sph_post_counter
  end
end
