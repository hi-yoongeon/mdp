class Region < ActiveRecord::Base
  has_many :stores
  
  validates_presence_of :position
end
