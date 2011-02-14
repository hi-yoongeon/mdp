class Message < ActiveRecord::Base
  belongs_to :users, :class_name => "User", :foreign_key => "user_id"

  validates_presence_of :sent_user_id, :received_user_id, :message
  #  validates_length_of :message, :within => 1..500
end
