class BookmarksController < ApplicationController
  before_filter :authentication_required, only => []
  reapond_to :xml, :json


  def new

  end


  def like

  end


  def list

  end


end
