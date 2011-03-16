# == Schema Information
# Schema version: 20110316100624
#
# Table name: followings
#
#  id                :integer         not null, primary key
#  following_user_id :integer         not null
#  followed_user_id  :integer         not null
#  sequence          :integer
#  created_at        :datetime
#  updated_at        :datetime
#

class Following < ApplicationModel#ActiveRecord::Base
  belongs_to :following_user, :class_name => "User", :foreign_key => "following_user_id"
  belongs_to :followed_user, :class_name => "User", :foreign_key => "followed_user_id"  
  

  validates_presence_of :following_user_id, :followed_user_id
  
end
