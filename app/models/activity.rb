class Activity < ActiveRecord::Base
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
  belongs_to :post, :class_name => "Post", :foreign_key => "foreign_key"
  belongs_to :store, :class_name => "Store", :foreign_key => "foreign_key"
  belongs_to :like, :class_name => "Like", :foreign_key => "foreign_key"
  
  validates_presence_of :user_id, :user_name, :object_type, :object_name, :object_id, :action
  validates_inclusion_of :action, :in => %w(Store Like Bookmark)
  validates_inclusion_of :object_type, :in => %w(User Post Store StoreFood)
  validates_inclusion_of :object_complement_type, :in => %w(Post Store StoreFood None)
  
  
  protected
  def self.generate(arg = {})
    if arg[:object_complement_type].nil?
      arg[:object_complement_type] = "None"
    end
    
    activity = Activity.new(arg)
    if activity.save
      # create post
      data = {}
      data[:post] = "activity"
      data[:activity_id] = activity.id
      data[:lat] = 0
      data[:lng] = 0
      if arg[:object_complement_type] != "None"
        object_type = arg[:object_complement_type]
        object_id = arg[:object_complement_id]
      else
        object_type = arg[:object_type]
        object_id = arg[:object_id]        
      end
      
      case object_type
      when "Post"
        post = Post.find(object_id)
        data[:lat] = post.lat
        data[:lng] = post.lng
      when "Store"
        store = Store.find(object_id)
        data[:lat] = store.lat
        data[:lng] = store.lng
      when "StoreFood"
        store = StoreFood.find(object_id).store
        data[:lat] = store.lat
        data[:lng] = store.lng
      else
      end
      
      post = Post.new(data)
      if post.save
        return post
      end
    end
    nil
  end


#   protected
#   def self.generate(arg = {})

#     # generate an activity post
#     user = User.find(arg[:user_id])
#     data = {}

#     case arg[:action]
#     when "like"
#       like = Like.find(arg[:foreign_key])
#       case like.type
#       when "store"
#         store = Store.find(like.foreign_key)
#         data[:store_id] = store.id
#         data[:lat] = store.lat
#         data[:lng] = store.lng
#         data[:post] = "#{user.nick} 님이 #{store.name} (을)를 좋아합니다"
#       when "post"
#         post = Post.find(like.foreign_key)
#         data[:store_id] = post.store_id
#         data[:lat] = post.lat
#         data[:lng] = post.lng
#         post_user = User.find(post.user_id)
#         data[:post] = "#{user.nick} 님이 #{post_user.nick} 님의 메모를 좋아합니다"
#       when "store_food"
#         store_food = StoreFood.find(like.foreign_key)
#         food = Food.find(store_food.food_id)
#         store = Store.find(store_food.store_id)
#         data[:store_id] = store.id
#         data[:lat] = store.lat
#         data[:lng] = store.lng
#         data[:post] = "#{user.nick} 님이 #{store.name} 의 #{food.name} (을)를 좋아합니다"
#       when "food"
#         # skip to generate activity
#       else
#       end

#     when "store"
#       store = Store.find(arg[:foreign_key])
#       data[:store_id] = store.id
#       data[:lat] = store.lat
#       data[:lng] = store.lng
#       data[:post] = "#{user.nick} 님이 맛집 #{store.name} (을)를 발굴하였습니다"
#     when "bookmark"
#       bookmark = Bookmark.find(arg[:foreign_key])
#       case bookmark.type
#       when "store"
#         store = Store.find(bookmark.foreign_key)
#         data[:store_id] = store.id
#         data[:lat] = store.lat
#         data[:lng] = store.lng
#         data[:post] = "#{user.nick} 님이 맛집 #{store.name} (을)를 즐겨찾기 하였습니다"
#       when "post"
#         post = Post.find(bookmark.foreign_key)
#         data[:store_id] = post.store_id
#         data[:lat] = post.lat
#         data[:lng] = post.lng
#         post_user = User.find(post.user_id)
#         data[:post] = "#{user.nick} 님이 #{post_user.nick} 님의 메모를 즐겨찾기 하였습니다"
#       when "region"
#         # skip to generate activity
#       else
#       end
      
#     else
#     end             
    
#     unless data.empty?
#       activity = new(:user_id => arg[:user_id], :foreign_key => arg[:foreign_key], :type => arg[:type])
#       if activity.save
#         data[:activity_id] = activity.id
#         data[:user_id] = arg[:user_id]
        
#         post = Post.new(data)
#         if post.save
#           return post
#         end
#       end
#     end
#     nil
#   end


end
