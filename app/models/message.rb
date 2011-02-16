class Message < ActiveRecord::Base
  belongs_to :sent_user, :class_name => "User", :foreign_key => "sent_user_id"
  belongs_to :received_user, :class_name => "User", :foreign_key => "received_user_id"

  validates_presence_of :sent_user_id, :received_user_id, :message
  #  validates_length_of :message, :within => 1..500
end
