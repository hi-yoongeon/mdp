class Client < ApplicationModel#ActiveRecord::Base
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
  
  validates_uniqueness_of :application_name
  attr_private :client_id, :client_secret, :redirect_uri
end
