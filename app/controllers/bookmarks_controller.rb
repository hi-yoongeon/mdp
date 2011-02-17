class BookmarksController < ApplicationController
  before_filter :authentication_required, :only => [:new]
  respond_to :xml, :json

  def new

  end

  def list

  end

end
