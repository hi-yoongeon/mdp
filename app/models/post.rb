class Post < ApplicationModel
  has_one :activity, :class_name => "Activity", :foreign_key => "id", :primary_key => "activity_id"
  has_many :likes, :conditions => {:object => "Post"}, :foreign_key => "foreign_key"
  has_many :attach_files, :dependent => :destroy
  has_many :post_tags, :dependent => :destroy
  has_many :tags, :through => :post_tags
  has_many :comments, :class_name => "PostComment", :foreign_key => "post_id"
  
  belongs_to :user, :class_name => "User", :foreign_key => 'user_id'
  belongs_to :store, :class_name => "Store", :foreign_key => 'store_id'

  validates_inclusion_of :from_where, :in => %w(WEB ANDROID IPHONE NONE)
  validates_length_of :post, :within => 1..300
  validates_presence_of :user_id, :post, :from_where
  
  ## private field setting
  #  attr_private :some_fields
  
  after_create :increase_post_count
  before_destroy :decrease_post_count


  private
  def increase_post_count
    if self.store_id
      Store.update_all("post_count = post_count + 1", "id = #{self.store_id}")
    end
    User.update_all("post_count = post_count + 1", "id = #{self.user_id}")
  end
  

  def decrease_post_count
    if self.store_id
      Store.update_all("post_count = post_count - 1", "id = #{self.store_id}")
    end
    User.update_all("post_count = post_count - 1", "id = #{self.user_id}")     
  end

end
