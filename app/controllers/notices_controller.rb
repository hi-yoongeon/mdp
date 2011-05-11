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
    ret = __find(Notice, conditions, nil)
    __respond_with ret
  end


  def badge
    if parameters_required :last_notice_id, :last_alarm_id
      ret = {}
      ret[:new_notice_count] = Notice.count(:conditions => ["id > ?", params[:last_notice_id]])
      ret[:new_alarm_count] = 0
      ret[:new_alarm_count] = Alarm.count(:conditions => ["received_user_id = ? AND id > ?", current_user.id, params[:last_alarm_id]]) if current_user
      
      __respond_with(ret)
    end
  end
  
  
end
