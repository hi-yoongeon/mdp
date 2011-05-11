class RegionsController < ApplicationController
  before_filter :authentication_required
  before_filter :http_get, :only => [:bookmarked_list]
  before_filter :http_post, :only => [:bookmark, :unbookmark]
  respond_to :xml, :json
  

  def bookmark
    if parameters_required :lat_sw, :lat_ne, :lng_sw, :lng_ne, :description
      region = Region.new(:user_id => current_user.id, :lat_sw => params[:lat_sw], :lat_ne => params[:lat_ne], :lng_sw => params[:lng_sw], :lng_ne => params[:lng_ne], :description => params[:description])
      if region.save
        bookmark = Bookmark.new(:object => "Region", :foreign_key => region.id, :user_id => current_user.id)
        if bookmark.save
          __success(bookmark.region)
          return
        else
          __error(:code => 0, :description => "Failed to save bookmark")
          return
        end
      else
        __error(:code => 0, :description => "Failed to save region")
      end
    end
  end

  
  def unbookmark
    if parameters_required :region_id
      region = Region.find(:first, :conditions => {:id => params[:region_id]})
      if region and region.user_id == current_user.id
        bookmark = Bookmark.find(:first, :conditions => {:object => "Region", :foreign_key => params[:region_id]})
        bookmark.destroy if bookmark
        region.destroy
        
        __success("OK")
        return
      else
        __error(:code => 0, :description => "Region id is not exist")
        return
      end
    end
  end

  
  def bookmarked_list
    conditions = {}
    conditions[:user_id] = current_user.id
    conditions[:object] = "Region"
    bookmarks = __find(Bookmark, conditions)    
    bookmarked_regions = bookmarks.map {|bookmark| bookmark.region}
    __respond_with bookmarked_regions, :include => [], :except => []
  end

  
end
