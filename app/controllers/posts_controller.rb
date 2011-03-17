class PostsController < ApplicationController
  before_filter :authentication_required, :only => [:new, :delete, :like, :my_list]
  before_filter :http_get, :only => [:show, :list, :reply_list ,:my_list, :nearby_list, :region_list]
  before_filter :http_post, :only => [:new, :delete, :like]
  respond_to :xml, :json


  def show
    if parameters_required :post_id
      params[:id] = params[:post_id]
      ret = __find(Post)
      __respond_with ret, :include => [], :except => []
    end
  end


  def new
    if parameters_required :post
      data = {}
      data[:post] = params[:post]
      data[:user_id] = current_user.id
      data[:lat] = 0
      data[:lng] = 0

      # test code
      data[:from_where] = "IPHONE" if data[:from_where].nil?
      data[:from_where].upcase!
      #
      
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
        # todo !!
        # attachfile process
        if params[:upload_file]
          require "attach_file_cache_manager"
          fcm = AttachFileCacheManager.new(post.id)
          uploaded_file = params[:upload_file]
          fcm.add_img(params[:upload_file])
          attach_file_data = {
            :user_id => current_user.id,
            :store_id => params[:store_id],
            :post_id => post.id,
            :filename => fcm.img_filename,
            :fullpath => fcm.img_path(:fullpath),
            :webpath => fcm.img_path(:webpath),
            :thumbnail => fcm.img_path(:webpath, :thumbnail => true)
          }
          AttachFile.new(attach_file_data).save
        end
        # Attachfile
        # Tag
        if params[:tags] and !params[:tags].empty?
          Tag.generate(:tags => params[:tags], :user_id => current_user.id, :post_id => post.id)
        end
        __success(post)
      else
        __error(:code => 0, :description => "Failed to save")
      end
    end
  end


  def delete
    if parameters_required :post_id
      post = Post.find(params[:post_id])
      if post.user_id == current_user.id
        post.destroy
        __success()
      else
        __error(:code => 0, :description => "Non authentication")
      end
    end
  end


  def like
    if parameters_required :post_id
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
    params[:id] = nil # remove id parameter for correct result
    conditions = {:parent_post_id => nil}
    ret = __find(Post, conditions)
    __respond_with ret, :include => [], :except => []
  end
  

  def reply_list
    if parameters_required :post_id
      params[:id] = nil
      conditions = {:parent_post_id => params[:post_id]}
      ret = __find(Post, conditions)
      __respond_with ret, :include => [], :except => []
    end
  end
  

  def my_list
    params[:id] = nil # remove id parameter for correct result
    conditions[:user_id] = current_user.id
    ret = __find(Post, conditions)
    __respond_with ret, :include => [], :except => [] 
  end


  def nearby_list
    if parameters_required :lat_sw, :lat_ne, :lng_sw, :lng_ne
      params[:id] = nil
      conditions = {}
      conditions[:lat] = params[:lat_sw].to_f .. params[:lat_ne].to_f
      conditions[:lng] = params[:lng_sw].to_f .. params[:lng_ne].to_f
      conditions[:parent_post_id] = nil
      ret = __find(Post, conditions)
      __respond_with ret, :include => [], :except => []
    end
  end


  def region_list
    if parameters_required # to do
      params[:id] = nil
      condnitions = {:parent_post_id => nil}
      ret = __find(Post, conditions)
      __respond_with ret, :include => [], :except => []
    end
  end


end
