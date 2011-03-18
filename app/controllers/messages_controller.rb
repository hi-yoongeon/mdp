class MessagesController < ApplicationController
  before_filter :authentication_required
  before_filter :http_get, :only => [:show, :list, :received_list, :sent_list]
  before_filter :http_post, :only => [:new, :delete]
  respond_to :xml, :json


  def new
    if parameters_required :received_user_id, :message
      msg = Message.new(:sent_user_id => current_user.id, :received_user_id => params[:received_user_id], :message => params[:message])
      if msg.save
        __success(msg)
        return
      else
        __error(:code => 0, :description => "Failed to send a message")
        return
      end
    end
  end


  def show
    if parameters_required :message_id
      msg = Messasge.find(params[:message_id])
      if msg.sent_user_id == current_user.id or msg.received_user_id == current_user.id
        __respond_with msg, :include => [], :except => []
      else
        __error(:code => 0, :description => "Non authentication")
      end
    end
  end


  def list
    ret = __find(Message)
    __respond_with ret, :include => [], :except => []
  end


  def received_list
    conditions = {}
    conditions[:received_user_id] = current_user.id
    ret = __find(Message, conditions)
    __respond_with ret, :include => [], :except => []
  end
  
  
  def sent_list
    conditions = {}
    conditions[:sent_user_id] = current_user.id
    ret = __find(Message, conditions)
    __respond_with ret, :include => [], :except => []
  end


  def delete
    if parameters_required :message_id
      msg = Messasge.find(params[:message_id])
      if msg.sent_user_id == current_user.id or msg.received_user_id == current_user.id
        msg.destroy
        __success()
      else
        __error(:code => 0, :description => "Non authentication")
      end
    end
  end

end
