class FollowingsController < ApplicationController
  before_filter :authentication_required, :only => [:new, :delete]

  
  def show
  end

  
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
  end
  
  
  def list
  end
  
end
