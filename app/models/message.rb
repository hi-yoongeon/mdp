# == Schema Information
# Schema version: 20110316100624
#
# Table name: messages
#
#  id               :integer         not null, primary key
#  sent_user_id     :integer         not null
#  received_user_id :integer         not null
#  message          :text            not null
#  sequence         :integer
#  created_at       :datetime
#  updated_at       :datetime
#

class Message < ApplicationModel#ActiveRecord::Base
  belongs_to :sent_user, :class_name => "User", :foreign_key => "sent_user_id"
  belongs_to :received_user, :class_name => "User", :foreign_key => "received_user_id"

  validates_presence_of :sent_user_id, :received_user_id, :message
  #  validates_length_of :message, :within => 1..500

  attr_private :sent_user_id, :received_user_id, :message
end
