class AttachfilesController < ApplicationController
  respond_to :xml, :json


  def list
    if request.get? 
      conditions = {}
      if params[:post_id]
        conditions = {:post_id => params[:post_id]}
      elsif params[:store_id]
        conditions = {:store_id => params[:store_id]}      
      end

      ret = __find(AttachFile, conditions)
      respond_with ret
    end
  end


end
