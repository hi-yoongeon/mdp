class Bookmark < ActiveRecord::Base
  belongs_to :users, :class_name => "User", :foreign_key => "user_id"
  belongs_to :posts, :class_name => "Post", :foreign_key => "foreign_key"
  belongs_to :stores, :class_name => "Store", :foreign_key => "foreign_key"
  
  validates_presence_of :user_id, :foreign_key, :type
  validates_inclusion_of :type, :in => %w(store post region)

end
