# == Schema Information
# Schema version: 20110316100624
#
# Table name: stores
#
#  id             :integer         not null, primary key
#  name           :string(255)     not null
#  reg_user_id    :integer
#  tel            :string(255)
#  address        :string(255)     not null
#  add_address    :string(255)
#  website        :string(255)
#  cover          :text
#  lat            :float           default(0.0), not null
#  lng            :float           default(0.0), not null
#  bookmark_count :integer         default(0), not null
#  like_count     :integer         default(0), not null
#  memo_count     :integer         default(0), not null
#  image_count    :integer         default(0), not null
#  sequence       :integer
#  created_at     :datetime
#  updated_at     :datetime
#

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
