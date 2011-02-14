class FoodController < ApplicationController
  before_filter :authentication_required, :only => [:add_food, :like_food]
  respond_to :xml, :json


  def add_food
    
  end


  def like_food

  end


  def list_food
    if request.get?
      __find(Post)
    end
  end

end
