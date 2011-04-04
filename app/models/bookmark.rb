class Bookmark < ApplicationModel
  belongs_to :user, :class_name => "User", :foreign_key => "user_id", :counter_cache => :store_count
  belongs_to :store, :class_name => "Store", :foreign_key => "foreign_key", :counter_cache => :bookmark_count
  belongs_to :region, :class_name => "Region", :foreign_key => "foreign_key"
  
  
  validates_presence_of :user_id, :foreign_key, :object
  validates_uniqueness_of  :user_id, :scope => [:foreign_key, :object]
  validates_inclusion_of :object, :in => %w(Store Region)

  
  
  
end
