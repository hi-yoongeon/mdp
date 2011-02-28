class AttachFile < ApplicationModel#ActiveRecord::Base
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
  belongs_to :store, :class_name => "Store", :foreign_key => "store_id"
  belongs_to :post, :class_name => "Post", :foreign_key => "post_id"

  
  validates_presence_of :user_id, :post_id, :filename, :fullpath, :webpath
  validates_uniqueness_of :filename
end
