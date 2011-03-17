class Alarm < ApplicationModel
  belongs_to :sent_user, :class_name => "User", :foreign_key => "sent_user_id"
  belongs_to :received_user, :class_name => "User", :foreign_key => "received_user_id"  
  validates_presence_of :sent_user_id, :received_user_id, :type
  validates_inclusion_of :type, :in => %w()

end
