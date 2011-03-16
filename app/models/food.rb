# == Schema Information
# Schema version: 20110316100624
#
# Table name: foods
#
#  id         :integer         not null, primary key
#  name       :string(255)     not null
#  like_count :integer         default(0), not null
#  sequence   :integer
#  created_at :datetime
#  updated_at :datetime
#

class Food < ApplicationModel#ActiveRecord::Base
  has_many :store_food, :dependent => :destroy
  has_many :like

  validates_presence_of :name
  validates_uniqueness_of :name

end
