class Like < ActiveRecord::Base
  has_many :activities, :dependent => :destroy

  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
  belongs_to :store, :class_name => "Store", :foreign_key => "foreign_key"
  belongs_to :bookmark, :class_name => "Bookmark", :foreign_key => "foreign_key"
  belongs_to :food, :class_name => "Food", :foreign_key => "foreign_key"
  belongs_to :post, :class_name => "Post", :foreign_key => "foreign_key"

  validates_presence_of :user_id, :foreign_key, :type
  validates_inclusion_of :type, :in => %w(store post store_food food)

  after_create :increase_like_count
  
  private
  def increase_like_count
    case type
    when "store"
      object = Store.find(foreign_key)
    when "post"
      object = Post.find(foreign_key)
    when "store_food"
      object = StoreFood.find(foreign_key)
    when "food"
      object = Food.find(foreign_key)
    else
      return 
    end
    
    object.update_attribute(:like_count, object.like_count + 1)
  end
end
