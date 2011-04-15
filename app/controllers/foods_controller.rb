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
      
      
      store_food = StoreFood.find(:first, :conditions => ["food_id = ? AND store_id = ?", food.id, params[:store_id]])
      if store_food
        if store_food.blind == true
          store_food.update_attribute(:blind, false)
        else
          __error(:code => 0 , :description => "The store_food is already exist")
          return
        end
      else
        store_food = StoreFood.new(:food_id => food.id, :store_id => store_id, :user_id => current_user.id, :like_count => like_count)
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

      __success(store_food)
      return
    end
  end

  
  # def update
  #   if parameters_required :store_food_id, :food_name
  #     food = Food.find(:first, :conditions => ["name = ?", params[:food_name]])
  #     if food.nil?
  #       food = Food.new(:name => params[:food_name])
  #       food.save
  #     end
      
  #     store_food = StoreFood.find(params[:store_food_id])
  #     store_food.update_attribute(:blind, 0)
  #     new_store_food = create_store_food(:store_id => store_food.store_id, :food_id => food.id, :like_count => store_food.like_count)
  #     if new_store_food
  #       data = {}
  #       data[:user_id] = current_user.id
  #       data[:store_id] = store_food.store_id
  #       data[:mod] = [store_food.id, new_store_food.id]
  #       data[:food_name] = "#{store_food.food.name}, #{new_store_food.food.name}"
  #       StoreFoodLog.logging(data)
  #     end
  #   end
  # end


  def delete
    if parameters_required :store_food_id
      store_food = StoreFood.find(:first, :conditions => ["id = ?",  params[:store_food_id]])
      
      if store_food
        store_food.update_attribute(:blind, true)
        data = {}
        data[:user_id] = current_user.id
        data[:store_id] = store_food.store_id
        data[:action] = "Delete"
        data[:food_name] = store_food.food.name
        StoreFoodLog.new(data).save
        __success("OK")
        return
      else
        __error(:code => 0 , :description => "The Store_food isn't exist")
        return
      end
    end
  end


  # def rollback
  #   if parameters_required :store_food_log_id
  #     prev_store_food_log = StoreFoodLog.find(params[:store_food_log_id])
  #     store_id = prev_store_food_log.store_id
  #     curr_store_food_log = StoreFoodLog.find(:first, :conditions => {:store_id => store_id} , :order => "updated_at DESC")

  #     if prev_store_food_log and curr_store_food_log
  #       StoreFood.update_all("blind = 0", "store_id = #{store_id} AND id IN (#{curr_store_food_log.store_food_ids})")
  #       StoreFood.update_all("blind = 1", "store_id = #{store_id} AND id IN (#{prev_store_food_log.store_food_ids})")
        
        
  #       data = {}
  #       data[:user_id] = current_user.id
  #       data[:store_id] = store_id
  #       data[:rb] = prev_store_food_log.id
  #       StoreFoodLog.logging(data)
  #       __success("OK")
  #       return
  #     end
      
  #     __error(:code => 0, :description => "Invalid store_food_log_id passed")
  #     return
  #   end
  # end

    
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
      conditions[:blind] = 0
      store_foods = __find(StoreFood, conditions)
      # foods = store_foods.map { |store_food| store_food.food }
      __respond_with store_foods, :include =>[:food]
    end
  end



end
