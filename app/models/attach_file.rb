class AttachFile < ActiveRecord::Base
  belongs_to :users, :class_name => "User", :foreign_key => "user_id"
  belongs_to :stores, :class_name => "Store", :foreign_key => "store_id"
  belongs_to :posts, :class_name => "Post", :foreign_key => "post_id"

  
  validates_presence_of :user_id, :post_id, :filename, :fullpath, :webpath
  validates_uniqueness_of :filename
end
