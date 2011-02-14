class NoticesController < ApplicationController
  before_filter :authentication_required
  respond_to :xml, :json


  def show

  end


  def list

  end


end
