# == Schema Information
# Schema version: 20110316100624
#
# Table name: clients
#
#  id               :integer         not null, primary key
#  user_id          :integer
#  application_name :string(255)
#  client_id        :string(255)
#  client_secret    :string(255)
#  redirect_uri     :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#

class Client < ApplicationModel#ActiveRecord::Base
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
  
  validates_uniqueness_of :application_name
  attr_private :client_id, :client_secret, :redirect_uri
end
