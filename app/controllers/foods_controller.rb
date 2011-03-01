class FoodController < ApplicationController
  before_filter :authentication_required, :except => [:list, :store_list]
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
    if request.post? and parameters_required :store_id, :store_food_id
      like = Like.new(:user_id => current_user.id, :object => "Store", :foreign_key => param[:store_id])
      if like.save
        data = {}
        data[:action] = "Like"
        data[:user_id] = current_user.id
        data[:user_name] = current_user.nick
        data[:object_type] = "Store"
        store = Store.find(params[:store_id])
        data[:object_name] = store.name
        data[:object_id] = store.id
        data[:object_complement_type] = "StoreFood"
        data[:object_complement_id] = params[:store_food_id]
        food = Food.find(params[:store_food_id])
        data[:object_complement_name] = food.name
        post = Activity.generate(data);
        if post
          __success(post)
          return
        else
          __error(:code => 0, :description => "Failed to generate activity")
          return
        end
      else
        __error(:code => 0, :description => "Failed to save like ")
      end
    end
  end


  def list
    if request.get?
      params[:id] = nil
      ret = __find(StoreFood)
      __respond_with ret, :include => [], :except => []
    end
  end


  def store_list
    if request.get? and parameters_required :store_id
      params[:id] = nil
      conditions = {}
      conditions[:store_id] = params[:store_id]
      ret = __find(StoreFood, conditions)
      __respond_with ret, :include => [], :except => []
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
