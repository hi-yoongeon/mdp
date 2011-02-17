class Tag < ActiveRecord::Base
  has_many :post_tags, :dependent => :destroy

  validates_presence_of :tag
  validates_uniqueness_of :tag
end
