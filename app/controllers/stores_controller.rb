class StoresController < ApplicationController
  before_filter :authentication_required, :only => [:new, :like, :my_list, :bookmarked_list]
  respond_to :xml, :json


  def show
    if request.get? and parameters_required :store_id
      params[:id] = params[:store_id]
      ret = __find(Store)
    end
    respond_with ret
  end


  def new
    

  end


  def like
    if request.post? and parameters_required :store_id
      # todo
      # create like object
      like = Like.new(:user_id => current_user.id, :object => "Store", :foreign_key => params[:store_id])
      if like.save
        data = {}
        data[:action] = "Like"
        data[:user_id] = current_user.id
        data[:user_name] = current_user.nick
        data[:object_type] = "Store"
        store = Store.find(params[:store_id])
        data[:object_name] = store.name
        data[:object_id] = store.id
        
        post = Activity.generate(data);
        if post
          __success(post)
          return
        else
          __error(:code => 0, :description => "Failed to generate activity")
          return
        end
      else
        __error(:code => 0, :description => "Failed to save like")
      end

    end
  end


  def bookmark
    if request.post? and parameters_required :store_id
      # create bookmark object
      bookmark = Bookmark.new(:object => "Store", :foreign_key => params[:store_id], :user_id => current_user.id)
      if bookmark.save
        # issue - generate activity??
        __success(bookmark)
      else
        __error(:code => 0, :description => "Failed to bookmark store")
      end
    end
  end


  def list
    if request.get?
      ret = __find(Store)
    end

    respond_with ret
  end

  
  def nearby_list
    if request.get? and parameters_required :lat_sw, :lat_ne, :lng_sw, :lng_ne
      
      conditions = {}
      conditions[:lat] = params[:lat_sw].to_f .. params[:lat_ne].to_f
      conditions[:lng] = params[:lng_sw].to_f .. params[:lng_ne].to_f
      
      ret = __find(Store, conditions)
    end
    
    respond_with ret
  end


  def bookmarked_list
    if request.get?
      conditions = {}
      conditions[:user_id] = current_user.id
      conditions[:object] = "Store"
      bookmarks = __find(Bookmark, conditions)
      bookmarked_stores = bookmarks.map { |bookmark| bookmark.store }
      respond_with bookmarked_stores
    end
  end


end
