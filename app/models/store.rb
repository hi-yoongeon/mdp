class Store < ApplicationModel#ActiveRecord::Base
  has_many :posts , :dependent => :nullify
  has_many :activities
  has_many :store_foods, :dependent => :destroy
  has_many :attach_files
  has_many :likes, :conditions => {:object => "Store"}, :foreign_key => "foreign_key"
  has_many :bookmarks, :conditions => {:object => "Store"}, :foreign_key => "foreign_key"
  has_many :tags, :class_name => "StoreTag", :foreign_key => "store_id",  :dependent => :destroy
  belongs_to :user, :class_name => "User", :foreign_key => "reg_user_id"
  
  validates_presence_of :user_id, :name, :address, :lat, :lng

end
