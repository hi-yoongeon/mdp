# == Schema Information
# Schema version: 20110316100624
#
# Table name: user_external_accounts
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  service    :string(255)
#  data       :text
#  sequence   :integer
#  created_at :datetime
#  updated_at :datetime
#

class UserExternalAccount < ApplicationModel#ActiveRecord::Base
  belongs_to :user, :class_name => "User", :foreign_key => 'user_id'

  validates_presence_of :user_id, :data

end
