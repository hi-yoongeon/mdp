class StoreFood < ActiveRecord::Base
  has_many :likes, :foreign_key => "foreign_key"

  belongs_to :store, :class_name => "Store", :foreign_key => "store_id"
  belongs_to :food, :class_name => "Food", :foreign_key => "food_id"

  validates_presence_of :food_id, :store_id, :food_name

end
