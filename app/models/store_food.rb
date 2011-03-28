# == Schema Information
# Schema version: 20110316100624
#
# Table name: store_foods
#
#  id         :integer         not null, primary key
#  user_id    :integer         not null
#  food_id    :integer         not null
#  store_id   :integer         not null
#  like_count :integer         default(0), not null
#  sequence   :integer
#  created_at :datetime
#  updated_at :datetime
#

class StoreFood < ApplicationModel#ActiveRecord::Base
  has_many :likes, :conditions => {:object => "StoreFood"}, :foreign_key => "foreign_key"


  belongs_to :store, :class_name => "Store", :foreign_key => "store_id"
  belongs_to :food, :class_name => "Food", :foreign_key => "food_id"

  validates_presence_of :food_id, :store_id
  validates_uniqueness_of  :food_id, :scope => [:store_id]

end
