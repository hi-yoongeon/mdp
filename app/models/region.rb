class Region < ActiveRecord::Base
  validates_presence_of :lat_sw, :lat_ne, :lng_sw, :lng_ne, :user_id
  validates_uniqueness_of :user_id, :scope => [:lat_sw, :lat_ne, :lng_sw, :lng_ne]
  
end
