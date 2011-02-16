class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.string :tag, :null => false
      t.integer :sequence
      
      t.timestamps
    end
  end

  def self.down
    drop_table :tags
  end
end

#=== Todo ====
#StoreTag
#PostTag
