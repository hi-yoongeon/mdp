# == Schema Information
# Schema version: 20110316100624
#
# Table name: posts
#
#  id             :integer         not null, primary key
#  user_id        :integer         not null
#  parent_post_id :integer
#  store_id       :integer
#  activity_id    :integer
#  post           :text            not null
#  image_count    :integer         default(0), not null
#  like_count     :integer         default(0), not null
#  lat            :float           default(0.0)
#  lng            :float           default(0.0)
#  from           :string(255)     not null
#  sequence       :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class Post < ApplicationModel#ActiveRecord::Base
  has_one :activity, :class_name => "Activity", :foreign_key => "id", :primary_key => "activity_id"
  has_many :likes, :conditions => {:object => "Post"}, :foreign_key => "foreign_key"
  has_many :attach_files, :dependent => :destroy
  has_many :tags, :class_name => "PostTag", :foreign_key => "post_id", :dependent => :destroy
  belongs_to :user, :class_name => "User", :foreign_key => 'user_id'
  belongs_to :store, :class_name => "Store", :foreign_key => 'store_id'
  belongs_to :parent_post, :class_name => "Post", :foreign_key => 'parent_post_id'
  
  validates_inclusion_of :from_where, :in => %w(WEB ANDROID IPHONE NONE)
  validates_length_of :post, :within => 1..300
  validates_presence_of :user_id, :post, :from_where
  
  ## private field setting
  #  attr_private :some_fields
end
