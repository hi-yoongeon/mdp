class CreateMileageStackDatas < ActiveRecord::Migration
  def self.up
    create_table :mileage_stack_datas do |t|
      t.integer :user_id
      t.string :flag
      t.integer :point
      t.integer :from_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :mileage_stack_datas
  end
end
