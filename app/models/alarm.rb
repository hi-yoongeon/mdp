class Alarm < ApplicationModel
  belongs_to :sent_user, :class_name => "User", :foreign_key => "sent_user_id"
  belongs_to :received_user, :class_name => "User", :foreign_key => "received_user_id"
  validates_presence_of :sent_user_id, :received_user_id, :alarm_type
  validates_inclusion_of :alarm_type, :in => %w(Following Message Comment PostLike)
  
  before_save :user_id_validates
  #attr_private :sent_user_id, :received_user_id, :type


  private
  def user_id_validates
    return false if self.sent_user_id == self.received_user_id
    
    true
  end
end
