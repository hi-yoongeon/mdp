class PostsController < ApplicationController
  before_filter :authentication_required, :only => [:new, :delete, :like, :my_list]
  respond_to :xml, :json


  def show
    if request.get? and parameters_required :post_id
      params[:id] = params[:post_id]
      ret = __find(Post)
      respond_with ret
    end
  end


  def new
    if request.post? and parameters_required :post
      data = {}
      data[:post] = params[:post]
      data[:user_id] = current_user.id
      data[:lat] = 0
      data[:lng] = 0
      
      if params[:store_id]
        data[:store_id] = params[:store_id]
        store = Store.find(params[:store_id])
        data[:lat] = store.lat
        data[:lng] = store.lng
      else
        data[:lat] = params[:lat] if params[:lat]
        data[:lng] = params[:lng] if params[:lng]
      end
      
      post = Post.new(data)
      if post.save
        __success(post)
      else
        __error(:code => 0, :description => "Failed to save")
      end

    end
  end


  def delete
    if reqeust.post? and parameters_required :post_id
      post = Post.find(params[:post_id])
      if post.user_id == current_user.id
        post.destroy
        __success()
      else
        __error(:code => 0, :description => "Failed to delete")
      end
    end
  end



  def like
    if request.get? and parameters_required :post_id
      # todo
      # create like object
      like = Like.new(:user_id => current_user.id, :object => "Post", :foreign_key => params[:post_id])
      if like.save
        data = {}
        data[:action] = "Like"
        data[:user_id] = current_user.id
        data[:user_name] = current_user.nick
        data[:object_type] = "User"
        post = Post.find(params[:post_id])
        data[:object_name] = post.user.nick
        data[:object_id] = post.user.id
        data[:object_complement_type] = "Post"
        data[:object_complement_id] = params[:post_id]
        data[:object_complement_name] = "" # unnessasary
        post = Activity.generate(data);
        if post
          __success(post)
          return
        else
          __error(:code => 0, :description => "Failed to generate activity")
          return
        end
      else
        __error(:code => 0, :description => "Failed to save like ")
      end

    end
  end



  def list
    if request.get?
      params[:id] = nil # remove id parameter for correct result
      ret = __find(Post)
      respond_with ret
    end
  end
  


  def my_list
    if request.get?
      params[:id] = nil # remove id parameter for correct result
      conditions = {}
      ret = __find(Post, conditions)
      respond_with ret
    end    
  end


  def nearby_list
    if request.get? and parameters_required :lat_sw, :lat_ne, :lng_sw, :lng_ne
      params[:id] = nil
      conditions = {}
      conditions[:lat] = params[:lat_sw].to_f .. params[:lat_ne].to_f
      conditions[:lng] = params[:lng_sw].to_f .. params[:lng_ne].to_f
      ret = __find(Post, conditions)
      respond_with ret
    end
  end
  

  def region_list
    if request.get? and parameters_required # to do
      params[:id] = nil
      condnitions = {}
      ret = __find(Post, conditions)
      respond_with ret
    end
  end

end
