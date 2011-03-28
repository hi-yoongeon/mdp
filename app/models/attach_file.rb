class AttachFile < ApplicationModel
  belongs_to :user, :class_name => "User", :foreign_key => "user_id" 
  belongs_to :store, :class_name => "Store", :foreign_key => "store_id"
  belongs_to :post, :class_name => "Post", :foreign_key => "post_id"
  validates_presence_of :user_id, :fullpath, :filename
  
end
