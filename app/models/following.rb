class Following < ActiveRecord::Base
  belongs_to :user, :class_name => "User", :foreign_key => "following_user_id"


  validates_presence_of :following_user_id, :followed_user_id
  
end
