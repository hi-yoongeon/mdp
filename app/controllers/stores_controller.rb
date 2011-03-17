class StoresController < ApplicationController
  before_filter :authentication_required, :only => [:new, :like, :my_list, :bookmark, :bookmarked_list]
  before_filter :http_get, :only => [:show, :list, :nearby_list, :bookmarked_list, :food_list, :my_list, :detail_list]
  before_filter :http_post, :only => [:show, :new, :like, :bookmark]
  respond_to :xml, :json


  def show
    if parameters_required :store_id
      params[:id] = params[:store_id]
      ret = __find(Store)
    __respond_with ret, :include => [], :except => []
    end
  end


  def new
    if parameters_required :store_name, :address, :lat, :lng
      data = {}
      data[:name] = params[:store_name]
      data[:reg_user_id] = current_user.id
      data[:address] = params[:address]
      data[:lat] = params[:lat]
      data[:lng] = params[:lng]
      data[:tel] = params[:tel] if params[:tel]
      data[:add_address] = params[:add_address] if params[:add_address]
      data[:website] = params[:website] if params[:website]
      data[:cover] = params[:cover] if params[:cover]
      store = Store.new(data)
      if store.save
        __success(store)
      else
        __error(:code => 0, :description => "Failed to save")
      end
    end
  end


  def like
    if parameters_required :store_id
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
    if parameters_required :store_id
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
    params[:id] = nil
    ret = __find(Store)
    __respond_with ret, :include => [], :except => []
  end


  def nearby_list
    if parameters_required :lat_sw, :lat_ne, :lng_sw, :lng_ne
      params[:id] = nil
      conditions = {}
      conditions[:lat] = params[:lat_sw].to_f .. params[:lat_ne].to_f
      conditions[:lng] = params[:lng_sw].to_f .. params[:lng_ne].to_f
      ret = __find(Store, conditions)
      __respond_with ret, :include => [], :except => []
    end
  end


  def bookmarked_list

    params[:id] = nil
    conditions = {}
    conditions[:user_id] = current_user.id
    conditions[:object] = "Store"
    bookmarks = __find(Bookmark, conditions)
    bookmarked_stores = bookmarks.map { |bookmark| bookmark.store }
    __respond_with bookmarked_stores, :include => [], :except => []

  end


  def food_list
    if parameters_required :store_id
      params[:id] = nil
      conditions = {}
      conditions[:store_id] = params[:store_id]
      store_foods = __find(StoreFood, conditions)
      foods = __find(Food, :id => store_foods.food_id)
      foods_name = foods.map { |food| food.name }
      __respond_with foods_name, :include => [], :except => []
    end
  end


  def my_list
    params[:id] = nil
    conditions = {}
    conditions[:user_id] = current_user.id
    ret = __find(Store, conditions)
    __respond_with ret, :include => [], :except => []
  end


  def detail_list
    if parameters_required :store_id
      params[:id] = nil
      conditions = {}
      conditions[:store_id] = params[:store_id]
      ret = __find(StoreDetailInfo, conditions)
      __respond_with ret
    end
  end

  
  
end
