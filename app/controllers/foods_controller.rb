class FoodController < ApplicationController
  before_filter :authentication_required, :except => [:list]
  respond_to :xml, :json



  def new
    if request.post? and parameters_required :store_id, :food_name
      food = Food.find(:first, :conditions => ["name = ?", params[:food_name]])
      if food.nil?
        food = Food.new(:name => params[:food_name])
        if food.save
          create_store_food(food.id)
          return
        else
          __error(:code => 0, :description => "Failed to save food")
          return
        end
        
      else
        create_store_food(food.id)
        return
      end
    end
  end



  def like
    
  end


  def list
    if request.get?
      params[:id] = nil
      ret = __find(StoreFood)
      respond_with ret
    end
  end



  def store_list
    if request.get? and parameters_required :store_id
      params[:id] = nil
      conditions = {}
      conditions[:store_id] = params[:store_id]
      ret = __find(StoreFood, conditions)

      respond_with ret
    end
  end



  def delete
    if request.post? and parameters_required :store_id, :food_id
      store_food = StoreFood.find(:first, :conditions => ["store_id = ? AND food_id = ? ", params[:store_id], params[:food_id]])
      if store_food
        if store_food.user_id == current_user.id
          store_food.destroy
          __success()
          return
        else
          __error(:code => 0, :description => "Non authentication")
          return
        end
      else
        __error(:code => 0 , :description => "The Store_food isn't exist")
        return
      end
    end
  end


  private 
  def create_store_food(food_id)
    store_food = StoreFood.new(:food_id => food_id, :store_id => params[:store_id], :user_id => current_user.id)
    if store_food.save
      __success(store_food)
    else
      __error(:code => 0, :description => "Failed to save store_food")
    end
  end


end
