class Food < ActiveRecord::Base
  has_many :store_foods, :dependent => :destroy
  has_many :likes, :dependent => :destroy

  validates_presence_of :name
  validates_uniqueness_of :name

end
