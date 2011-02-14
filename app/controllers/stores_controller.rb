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

  end


  def list
    if request.get?
      ret = __find(Store)
    end

    respond_with ret
  end


  def my_list
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


  def region_list

  end


  def bookmarked_list

  end


end
