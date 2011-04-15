class PostComment < ApplicationModel
  belongs_to :user
  belongs_to :post, :counter_cache => :comment_count
  
  validates_inclusion_of :from_where, :in => %w(WEB ANDROID IPHONE NONE)
  validates_length_of :comment, :within => 1..200
  validates_presence_of :user_id, :post_id, :comment, :from_where
  
end
