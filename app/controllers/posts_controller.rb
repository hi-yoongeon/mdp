class PostsController < ApplicationController
  before_filter :authentication_required, :only => [:write_post]
  respond_to :xml, :json


  def show_post
    if request.get?
      __find(Post)
    end
  end

  
  def write_post
    user_id = current_user.id
    store_id = params[:store_id]
    #respond_with current_user
  end


  def public_timeline
    if request.get?
      __find(Post)
    end
  end

  
end
