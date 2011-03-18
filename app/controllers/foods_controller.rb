class FoodsController < ApplicationController
  before_filter :authentication_required, :except => [:list]
  before_filter :http_get, :only => [:list]
  before_filter :http_post, :only => [:new, :update, :delete, :like]
  respond_to :xml, :json


  def new
    if parameters_required :store_id, :food_name
      food = Food.find(:first, :conditions => ["name = ?", params[:food_name]])
      if food.nil?
        food = Food.new(:name => params[:food_name])
        unless food.save
          __error(:code => 0, :description => "Failed to save food")
          return
        end
      end
      new_store_food = create_store_food(params[:store_id], food.id)
      if new_store_food
        data = {}
        data[:user_id] = current_user.id
        data[:store_id] = new_store_food.store_id
        data[:add] = new_store_food.id
        StoreFoodLog.logging(data) 
      end
      return
    end
  end

  
  def update
    if parameters_required :store_food_id, :food_name
      food = Food.find(:first, :conditions => ["name = ?", params[:food_name]])
      if food.nil?
        food = Food.new(:name => params[:food_name])
        food.save
      end
      store_food = StoreFood.find(params[:store_food_id])
      store_food.update_attribute(:blind, 0)
      new_store_food = create_store_food(store_food.store.id, food.id)
      if new_store_food
        data = {}
        data[:user_id] = current_user.id
        data[:store_id] = store_food.store_id
        data[:mod] = "#{store_food.id},#{new_store_food.id}"
        StoreFoodLog.logging(data)
      end
    end
  end


  def delete
    if parameters_required :store_food_id
      store_food = StoreFood.find(params[:store_food_id])
      
      if store_food
        if store_food.user_id == current_user.id
          store_food.update_attribute(:blind, 0)
          data = {}
          data[:user_id] = current_user.id
          data[:store_id] = store_food.store_id
          data[:del] = store_food.id
          StoreFoodLog.logging(data)          
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

    
  def like
    if parameters_required :store_food_id
      store_food = StoreFood.find(params[:store_food_id])
      if store_food.nil?
        __error(:code => 0, :descriptions => "Invalid store food id..")
        return
      end
      like = Like.new(:user_id => current_user.id, :object => "StoreFood", :foreign_key => param[:store_food_id])
      if like.save
        data = {}
        data[:action] = "Like"
        data[:user_id] = current_user.id
        data[:user_name] = current_user.nick
        data[:object_type] = "Store"
        data[:object_name] = store_food.store.name
        data[:object_id] = store_food.store.id
        data[:object_complement_type] = "Food"
        data[:object_complement_id] = store_food.food.id
        data[:object_complement_name] = store_food.food.name
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
    if parameters_required :store_id
      params[:id] = nil
      conditions = {}
      conditions[:store_id] = params[:store_id]
      store_foods = __find(StoreFood, conditions)
      __respond_with store_foods, :include => [:food], :except => []
    end
  end



  private 
  def create_store_food(store_id, food_id)
    store_food = StoreFood.new(:food_id => food_id, :store_id => store_id, :user_id => current_user.id, :blind => 1)
    if store_food.save
      __success(store_food)
      return store_food
    else
      __error(:code => 0, :description => "Failed to save store_food")
      return false
    end
  end

end
