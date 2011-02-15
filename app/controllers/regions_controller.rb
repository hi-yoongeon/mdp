class RegionsController < ApplicationController
  before_filter :authentication_required
  respond_to :xml, :json
  

  def bookmark
    if request.post? and parameters_required :lat_sw, :lat_ne, :lng_sw, :lng_ne
      region = Region.new(:user_id => current_user.id, :lat_sw => params[:lat_sw], :lat_ne => params[:lat_ne], :lng_sw => params[:lng_sw], :lng_ne => params[:lng_ne])
      if region.save
        bookmark = Bookmark.new(:object => "Region", :foreign_key => region.id, :user_id => current_user.id)
        if bookmark.save
          __success(bookmark)
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

  
  def bookmarked_list
    if request.get?
      conditions = {}
      conditions[:user_id] = current_user.id
      conditions[:object] = "Region"
      bookmarks = __find(Bookmark, conditions)
      bookmarked_regions = bookmarks.map { |bookmark| bookmark.region }
      respond_with bookmarked_retions
    end
  end
  
end
