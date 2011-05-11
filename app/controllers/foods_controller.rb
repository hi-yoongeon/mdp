class FoodsController < ApplicationController
  before_filter :authentication_required, :except => [:list]
  before_filter :http_get, :only => [:list]
  before_filter :http_post, :only => [:new, :update, :delete, :like, :unlike]
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
      
      
      store_food = StoreFood.find(:first, :conditions => ["food_id = ? AND store_id = ?", food.id, params[:store_id]])
      
      if store_food
        if store_food.blind == true
          store_food.update_attribute(:blind, false)
        else
          __error(:code => 0 , :description => "The store_food is already exist")
          return
        end
        
      else
        store_food = StoreFood.new(:food_id => food.id, :store_id => params[:store_id], :user_id => current_user.id)
        unless store_food.save
          __error(:code => 0, :description => "Failed to save store_food")
          return
        end
      end
      
      data = {}
      data[:user_id] = current_user.id
      data[:store_id] = store_food.store_id
      data[:action] = "Add"
      data[:food_name] = store_food.food.name
      StoreFoodLog.new(data).save

      __respond_with store_food, :include => [:store, :food]
      return
    end
  end


  def delete
    if parameters_required :store_food_id
      store_food = StoreFood.find(:first, :conditions => ["id = ?",  params[:store_food_id]])
      
      if store_food 
        if store_food.user_id == current_user.id
          store_food.update_attribute(:blind, true)
          data = {}
          data[:user_id] = current_user.id
          data[:store_id] = store_food.store_id
          data[:action] = "Delete"
          data[:food_name] = store_food.food.name
          StoreFoodLog.new(data).save
          __success("The store_food deleted")
          return          
        else
          data = {}
          data[:user_id] = current_user.id
          data[:store_food_id] = store_food.id
          DeleteRequestedStoreFood.new(data).save
          __success("The store_food deleted after confirmation of administrator")
        end

      else
        __error(:code => 0 , :description => "The store_food doesn't exist")
        return
      end
    end
  end

    
  def like
    if parameters_required :store_food_id
      store_food = StoreFood.find(:first, :conditions => ["id = ?", params[:store_food_id]])
      if store_food.nil?
        __error(:code => 0, :descriptions => "Invalid store food id..")
        return
      end
      like = Like.new(:user_id => current_user.id, :object => "StoreFood", :foreign_key => store_food.id)
      if like.save
        data = {}
        data[:post] = "The #{store_food.food.name} is delicious!"
        data[:user_id] = current_user.id
        data[:lat] = store_food.store.lat
        data[:lng] = store_food.store.lng
        data[:from_where] = "NONE"
        data[:store_id] = store_food.store.id
        post = Post.new(data)
        
        if post.save
          __success(like)
          return
        else
          __error(:code => 0, :description => "Failed to generate a post")
          return
        end
      else
        __error(:code => 0, :description => "Failed to like a post ")
      end
    end
  end


  def unlike
    if parameters_required :store_food_id
      store_food = StoreFood.find(:first, :conditions => ["id = ?", params[:store_food_id]])
      if store_food.nil?
        __error(:code => 0, :descriptions => "Invalid store food id..")
        return
      end
      
      like = Like.find(:first, :conditions => {:user_id => current_user.id, :object => "StoreFood", :foreign_key => store_food.id})
      
      if like
        like.destroy
        __success("OK")
      else
        __error(:code => 0, :descriptions => "You didn't like the store food")
        return
      end
      
    end
  end

  
  def list
    if parameters_required :store_id
      params[:id] = nil
      conditions = {}
      conditions[:store_id] = params[:store_id]
      conditions[:blind] = 0
      store_foods = __find(StoreFood, conditions)
      # foods = store_foods.map { |store_food| store_food.food }
      __respond_with store_foods, :include =>[:food]
    end
  end



end
