class NoticesController < ApplicationController
  respond_to :xml, :json


  def show
    if reqeust.get? and parameters_required :notice_id
      ret = Notice.find(params[:notice_id])
      respond_with ret
    end
  end


  def list
    if request.get?
      conditions = {}
      ret = __find(Notice, conditions)
      respond_with ret
    end
  end


end
