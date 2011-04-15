# -*- coding: utf-8 -*-
class StoresController < ApplicationController
  before_filter :authentication_required, :only => [:new, :like, :unlike, :bookmark, :unbookmark, :new_detail]
  before_filter :http_get, :only => [:show, :list, :nearby_list, :bookmarked_list, :food_list, :detail_list]
  before_filter :http_post, :only => [:like, :unlike, :new, :bookmark, :unbookmark, :new_detail]

  respond_to :xml, :json


  # Store show API
  def show
    if parameters_required :store_id
      params[:id] = params[:store_id]
      ret = __find(Store)
      __respond_with ret, :include => [], :except => []
    end
  end



  # New Store API
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



  # Store Like API
  def unlike
    if parameters_required :store_id
      like = Like.find(:first, :conditions => {:user_id => current_user.id, :object => "Store", :foreign_key => params[:store_id]})
      if like
        like.destroy
        __success("OK")
        return
      else
        __error(:code => 0 , :description => "No result for unliking")
        return
      end
    end
  end

  
  def like
    if parameters_required :store_id
      like = Like.find(:first, :conditions => {:user_id => current_user.id, :object => "Store", :foreign_key => params[:store_id]})
      if like
        __error(:code => 0, :description => "You already like this")
        return
      end
      
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
        return
      end
    end
  end


  # Store Bookmark API
  def bookmark
    if parameters_required :store_id
      # create bookmark object
      bookmark = Bookmark.new(:object => "Store", :foreign_key => params[:store_id], :user_id => current_user.id)
      if bookmark.save
        ##############################
        # issue - generate activity??
        ##############################        
        __success(bookmark)
      else
        __error(:code => 0, :description => "Failed to bookmark store")
      end
    end
  end

  
  def unbookmark
    if parameters_required :store_id
      bookmark = Bookmark.find(:first , :conditions => {:object => "Store", :foreign_key => params[:store_id], :user_id => current_user.id})
      if bookmark
        bookmark.destroy
        __success("OK")
        return
      else
        __error(:code => 0, :description => "Not exist such a record of store bookmark")
      end
    end
  end



  # Store List API
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
    if params[:user_id].nil? and current_user
      params[:user_id] = current_user.id
    end
    
    if parameters_required :user_id
      params[:id] = nil
      conditions = {}
      conditions[:object] = "Store"
      conditions[:user_id] = params[:user_id]
      bookmarks = __find(Bookmark, conditions)
      bookmarked_stores = bookmarks.map { |bookmark| bookmark.store }
      __respond_with bookmarked_stores, :include => [], :except => []
    end
  end



  
  # def my_list
  #   params[:id] = nil
  #   conditions = {}
  #   conditions[:user_id] = current_user.id
  #   ret = __find(Store, conditions)
  #   __respond_with ret, :include => [], :except => []
  # end



  # Store Detail API
  def detail_list
    if parameters_required :store_id
      params[:id] = nil
      conditions = {}
      conditions[:store_id] = params[:store_id]
      ret = __find(StoreDetailInfo, conditions)
      __respond_with ret
    end
  end



  def new_detail
    if parameters_required :store_id, :note   # --> 일단은 노트만.. 추후에 더 많은 필드 필요할 예정 
      detail_info = StoreDetailInfo.new(:user_id => current_user.id, :store_id => params[:store_id], :note => params[:note])
      if detail_info.save
        __success(detail_info)
      else
        __error(:code => 0, :msg => "Failed to save store detail information")
      end
    end
  end
  


  def rollback_detail
    if parameters_required :store_detail_info_id
      detail_info = StoreDetailInfo.find(:first, :conditions => ["id =? ", params[:store_detail_info_id]])
      if detail_info
        time = Time.new
        detail_info.update_attribute(:updated_at, time)
      else
        
      end
    end
    
  end

  
end
