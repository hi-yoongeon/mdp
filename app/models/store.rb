class Store < ActiveRecord::Base
  has_many :posts
  has_many :activities
  has_many :store_foods
  has_many :attach_files
  has_many :likes
  has_many :bookmarks
  has_mant :store_tags, :dependent => :destroy

  belongs_to :region, :class_name => "Region", :foreign_key => "position"
  belongs_to :user, :class_name => "User", :foreign_key => "reg_user_id"

  
  validates_presence_of :user_id, :region_id, :name, :address, :lat, :lng

end
