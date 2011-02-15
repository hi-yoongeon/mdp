class FoodController < ApplicationController
  before_filter :authentication_required, :only => [:add_food, :like_food]
  respond_to :xml, :json


  def new
    
  end


  def like
    
  end


  def list
    
  end

end
