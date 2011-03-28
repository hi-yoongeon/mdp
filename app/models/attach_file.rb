# == Schema Information
# Schema version: 20110316100624
#
# Table name: attach_files
#
#  id         :integer         not null, primary key
#  user_id    :integer         not null
#  store_id   :integer
#  post_id    :integer
#  filename   :string(255)     not null
#  fullpath   :string(255)     not null
#  webpath    :string(255)     not null
#  sequence   :integer
#  created_at :datetime
#  updated_at :datetime
#

class AttachFile < ApplicationModel
  belongs_to :user, :class_name => "User", :foreign_key => "user_id" 
  belongs_to :store, :class_name => "Store", :foreign_key => "store_id"
  belongs_to :post, :class_name => "Post", :foreign_key => "post_id"
  validates_presence_of :user_id, :fullpath, :filename
  
end
