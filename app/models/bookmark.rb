class Bookmark < ApplicationModel#ActiveRecord::Base
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
  belongs_to :store, :class_name => "Store", :foreign_key => "foreign_key"
  belongs_to :region, :class_name => "Region", :foreign_key => "foreign_key"
  

  validates_presence_of :user_id, :foreign_key, :object
  validates_uniqueness_of  :user_id, :scope => [:foreign_key, :object]
  validates_inclusion_of :object, :in => %w(Store Region)
  
end
