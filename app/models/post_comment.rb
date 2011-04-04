class PostComment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post, :counter_cache => :comment_count
  
  validates_length_of :comment, :within => 1..200
  validates_presence_of :user_id, :post_id, :comment
  
end
