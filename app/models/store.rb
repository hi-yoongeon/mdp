class Store < ActiveRecord::Base
  has_many :posts, :dependent => :nullify
  has_many :activities, :dependent => :destroy
  has_many :store_foods
  has_many :attach_files
  has_many :likes
  has_many :bookmarks, :dependent => :destroy

  belongs_to :regions, :class_name => "Region", :foreign_key => "position"
  belongs_to :users, :class_name => "User", :foreign_key => "reg_user_id"

  
  validates_presence_of :user_id, :region_id, :name, :address, :lat, :lng

end
