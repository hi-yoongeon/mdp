class FollowingsController < ApplicationController
  before_filter :authentication_required, :only => [:new, :delete]


  def new
    if request.post? and parameters_required :followed_user_id
      following_user_id = current_user.id
      followed_user_id = params[:followed_user_id]
      
      follow = Following.new(:following_user_id => following_user_id, :followed_user_id => followed_user_id)
      if follow.save
        __success(follow)
      else
        __error(:code => 0, :description => "Failed to follow")
      end
    end
  end
  
  
  def delete
    if request.post? and parameters_required :followed_id
      following_user_id = current_user.id
      followed_user_id = params[:followed_user_id]
      
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
    if request.get?
      conditions = {:following_user_id => current_user.id}
      ret = __find(Following, conditions)
      __respond_with ret, :include => [], :except => []
    end
  end

  
  def follower_list
    if request.get?
      conditions = {:followed_user_id => current_user.id}
      ret = __find(Following, conditions)
      __respond_with ret, :include => [], :except => []
    end
  end  

end
