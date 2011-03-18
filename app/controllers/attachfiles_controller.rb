class AttachfilesController < ApplicationController
  before_filter :http_get, :only => [:list]
  respond_to :xml, :json


  def list
    conditions = {}
    if params[:post_id]
      conditions = {:post_id => params[:post_id]}
    elsif params[:store_id]
      conditions = {:store_id => params[:store_id]}      
    end
      ret = __find(AttachFile, conditions)
    __respond_with ret, :include => [], :except => []
  end

end
