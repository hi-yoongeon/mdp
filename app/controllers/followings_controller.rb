class FollowingsController < ApplicationController
  before_filter :authentication_required, :only => [:new, :delete]


  def new
    if request.post? and parameters_required :followed_user_id
      following_user_id = current_user.id
      followed_user_id = params[:followed_user_id]
      
      require "user_file_cache_manager"
      ufcm = UserFileCacheManager.new(followed_user_id)
      ufcm.add_follower(following_user_id)
      ufcm = UserFileCacheManager.new(following_user_id)
      ufcm.add_following(followed_user_id)
      
      follow = Following.new(:following_user_id => following_user_id, :followed_user_id => followed_user_id)
      if follow.save
        __success(follow)
      else
        __error(:code => 0, :description => "Failed to follow")
      end
    end
  end
  
  
  def delete
    if request.post? and parameters_required :followed_user_id
      following_user_id = current_user.id
      followed_user_id = params[:followed_user_id]
      
      require "user_file_cache_manager"
      ufcm = UserFileCacheManager.new(following_user_id)
      ufcm.remove_following(followed_user_id) 
      ufcm = UserFileCacheManager.new(followed_user_id)
      ufcm.remove_followed(following_user_id) 
      
      follow = Following.find(:first, :conditions => ["following_user_id = ? AND followed_user_id =?", following_user_id, followed_user_id])
      if follow
        follow.destroy
        __success()
        return
      else
        __error(:code => 0, :description => "The Following isn't exist")
        return
      end
    end
  end
  
  
  def list
    if request.get?
      ret = __find(Following)
      __respond_with ret, :include => [], :except => []
    end
  end
  

  def following_list
    if request.get? and parameters_required :user_id
      following_user_id = params[:user_id]
      require "user_file_cache_manager"
      mfcm = UserFileCacheManager.new(following_user_id)
      following_ids = mfcm.following
      params[:id] = following_ids
      params[:id] = "0" if params[:id].nil?

      ret = __find(User)
      __respond_with ret, :include => [], :except => []
    end
  end

  
  def follower_list
    if request.get? and parameters_required :user_id
      followed_user_id = params[:user_id]
      require "user_file_cache_manager"
      mfcm = UserFileCacheManager.new(followed_user_id)
      follower_ids = mfcm.follower
      params[:id] = follower_ids
      params[:id] = "0" if params[:id].nil?       
      
      ret = __find(User)
      __respond_with ret, :include => [], :except => []
    end
  end  

  def add_test
    require "user_file_cache_manager"
    followed_user_id = params[:followed_user_id]
    following_user_id = current_user.id
    
    ufcm = UserFileCacheManager.new(followed_user_id)
    ufcm.add_follower(following_user_id)
    ufcm = UserFileCacheManager.new(following_user_id)
    ufcm.add_following(followed_user_id)
    
    render :text => ufcm.following
  end

  def delete_test
    following_user_id = current_user.id
    followed_user_id = params[:followed_user_id]
    
    require "user_file_cache_manager"
    ufcm = UserFileCacheManager.new(followed_user_id)
    ufcm.remove_followed(following_user_id)
    ufcm = UserFileCacheManager.new(following_user_id)
    ufcm.remove_following(followed_user_id) 

    render :text => ufcm.following
  end
  
end
