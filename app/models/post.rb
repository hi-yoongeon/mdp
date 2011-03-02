class Post < ApplicationModel#ActiveRecord::Base
  has_one :activity, :class_name => "Activity", :foreign_key => "id", :primary_key => "activity_id"
  has_many :likes, :conditions => {:object => "Post"}, :foreign_key => "foreign_key"
  has_many :attach_files, :dependent => :destroy
  has_many :tags, :class_name => "PostTag", :foreign_key => "post_id", :dependent => :destroy
  belongs_to :user, :class_name => "User", :foreign_key => 'user_id'
  belongs_to :store, :class_name => "Store", :foreign_key => 'store_id'
  belongs_to :parent_post, :class_name => "Post", :foreign_key => 'parent_post_id'
  validates_length_of :post, :within => 1..300
  validates_presence_of :user_id, :post
  after_create :update_sequence  

  ## private field setting
  #  attr_private :some_field

  
  private
  def update_sequence
    update_attribute(:sequence, id * -1)
  end


end
