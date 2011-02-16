class MessagesController < ApplicationController
  before_filter :authentication_required
  respond_to :xml, :json


  def new
    if request.post? and parameters_required :received_user_id, :message
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
    if request.get? and parameters_required :message_id
      msg = Messasge.find(params[:message_id])
      if msg.sent_user_id == current_user.id or msg.received_user_id == current_user.id
        respond_with msg
      else
        __error(:code => 0, :description => "Non authentication")
      end
    end
  end


  def list
    if request.get?
      ret = __find(Message)
      respond_with ret
    end
  end


  def received_list
    if request.get?
      conditions = {}
      conditions[:received_user_id] = current_user.id
      ret = __find(Message, conditions)
      respond_with ret
    end
  end
  
  
  def sent_list
    conditions = {}
    conditions[:sent_user_id] = current_user.id
    ret = __find(Message, conditions)
    respond_with ret    
  end


  def delete
    if request.post? and parameters_required :message_id
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
