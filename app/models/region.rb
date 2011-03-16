# == Schema Information
# Schema version: 20110316100624
#
# Table name: regions
#
#  id         :integer         not null, primary key
#  user_id    :integer         not null
#  lat_sw     :float           default(0.0), not null
#  lng_sw     :float           default(0.0), not null
#  lat_ne     :float           default(0.0), not null
#  lng_ne     :float           default(0.0), not null
#  sequence   :integer
#  created_at :datetime
#  updated_at :datetime
#

class Region < ApplicationModel#ActiveRecord::Base
  validates_presence_of :lat_sw, :lat_ne, :lng_sw, :lng_ne, :user_id
  validates_uniqueness_of :user_id, :scope => [:lat_sw, :lat_ne, :lng_sw, :lng_ne]
  
end
