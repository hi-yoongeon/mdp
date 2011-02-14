class MessagesController < ApplicationController
  before_filter :authentication_required
  respond_to :xml, :json


  def new

  end


  def show
    if request.get?
      __find(Post)
    end
  end


  def list
    if request.get?
      __find(Post)
    end
  end


end
