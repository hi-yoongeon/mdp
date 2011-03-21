# == Schema Information
# Schema version: 20110316100624
#
# Table name: user_extra_infos
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  title      :string(255)
#  intro      :string(255)
#  post_count :integer
#  sequence   :integer
#  created_at :datetime
#  updated_at :datetime
#

class UserExtraInfo < ApplicationModel#ActiveRecord::Base
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"

  validates_presence_of :user_id
end
