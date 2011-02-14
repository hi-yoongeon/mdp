class PostsController < ApplicationController
  before_filter :authentication_required, :only => [:new, :delete, :like]
  respond_to :xml, :json


  def new
    if request.post? and parameters_required :post
      data = {}
      data[:post] = params[:post]
      data[:user_id] = current_user.id
      if params[:store_id]
        data[:store_id] = params[:store_id]
      end
      

      
      post = Post.new()
      if post.save
        ret = {:success => true, :post => post}
      else
        ret = {:success => false}
      end
      respond_with ret
    end
  end


  def delete

  end


  def like

  end


  def show
    if request.get? and parameters_required :post_id
      params[:id] = params[:post_id]
      ret = __find(Post)
    end
    
    respond_with ret
  end


  def list
    if request.get?
      ret = __find(Post)
    end
    respond_with ret
  end

  
  def nearby_list

  end


  def region_list

  end


end
