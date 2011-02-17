class Food < ActiveRecord::Base
  has_many :store_food, :dependent => :destroy
  has_many :like

  validates_presence_of :name
  validates_uniqueness_of :name

end
