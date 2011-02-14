class MessagesController < ApplicationController
  before_filter :authentication_required
  respond_to :xml, :json


  def list_message
    if request.get?
      __find(Post)
    end
  end


  def send_message

  end


  def show_message
    if request.get?
      __find(Post)
    end
  end


end
