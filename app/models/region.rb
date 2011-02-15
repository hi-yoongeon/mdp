class Region < ActiveRecord::Base
  has_many :stores
  
  validates_presence_of :lat_sw, :lat_ne, :lng_sw, :lng_ne

end
