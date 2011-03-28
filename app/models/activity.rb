class Activity < ApplicationModel#ActiveRecord::Base
  
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
      data[:user_id] = arg[:user_id]
      data[:post] = "This is an activity memo"
      data[:activity_id] = activity.id
      data[:lat] = 0
      data[:lng] = 0
      data[:from_where] = "NONE"
      
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
        data[:store_id] = store.id
        data[:lat] = store.lat
        data[:lng] = store.lng
      when "StoreFood"
        store = StoreFood.find(object_id).store
        data[:store_id] = store.id
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

end
