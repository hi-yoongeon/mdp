class NoticesController < ApplicationController
  respond_to :xml, :json


  def show
    if reqeust.get? and parameters_required :notice_id
      ret = Notice.find(params[:notice_id])
      __respond_with ret
    end
  end


  def list
    if request.get?
      conditions = {}
      ret = __find(Notice, conditions)
      __respond_with ret
    end
  end

end
