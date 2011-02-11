class Post < ActiveRecord::Base
  #validates_length_of :post, :within => 1..300
  validates_presence_of :user_id, :post
  #validates_uniqueness_of :userid, :email
  #validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Invalid email"
end
