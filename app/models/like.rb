class Like < ActiveRecord::Base
  has_many :activities, :depentent => :destroy

  belongs_to :users, :class_name => "User", :foreign_key => "user_id"
  belongs_to :stores, :class_name => "Store", :foreign_key => "foreign_key"
  belongs_to :bookmarks, :class_name => "Bookmark", :foreign_key => "foreign_key"
  belongs_to :foods, :class_name => "Food", :foreign_key => "foreign_key"
  belongs_to :posts, :class_name => "Post", :foreign_key => "foreign_key"

  validates_presence_of :user_id, :foreign_key
end
