class NoticesController < ApplicationController
  before_filter :http_get, :only => [:show, :list]
  respond_to :xml, :json

  def show
    if parameters_required :notice_id
      ret = Notice.find(params[:notice_id])
      __respond_with ret
    end
  end


  def list
    conditions = {}
    ret = __find(Notice, conditions)
    __respond_with ret
  end


end
