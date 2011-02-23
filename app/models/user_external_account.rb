class UserExternalAccount < ActiveRecord::Base
  belongs_to :user, :class_name => "User", :foreign_key => 'user_id'

  validates_presence_of :user_id, :data

end
