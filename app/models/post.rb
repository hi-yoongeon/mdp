class Post < ActiveRecord::Base
  has_many :bookmarks, :dependent => :destroy
  has_many :likes, :dependent => :destroy
  has_many :attach_files, :dependent => :destroy
  has_one :activity, :dependent => :destroy

  belongs_to :user, :class_name => "User", :foreign_key => 'user_id'
  belongs_to :store, :class_name => "Store", :foreign_key => 'store_id'

  validates_length_of :post, :within => 1..300
  validates_presence_of :user_id, :post
  
  after_create :update_sequence

  def update_sequence
    update_attribute(:sequence, id * -1)
  end
    
end
