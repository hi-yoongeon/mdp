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
    if request.get? and parameters_required :type
      conditions = {}
      case params[:type]
      when "received"
        conditions[:received_user_id] = current_user.id
      when "sent"
        conditions[:sent_user_id] = current_user.id
      else
        return
      end
      
      ret = __find(Message, conditions)
      respond_with ret
    end
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
