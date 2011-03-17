class StoreFoodLog < ActiveRecord::Base
  belongs_to :store
  belongs_to :user
  
  validates_presence_of :store_id, :user_id, :status

  protected
  def self.logging(opt = {})
    user_id = opt[:user_id]
    store_id = opt[:store_id]
    status = ""    
    if opt[:rb]
      store_food_log = find(opt[:rb])
      store_food_ids = store_food_log.store_food_ids
      status << "rb," << opt[:rb].to_s

    else
      store_food_log = find(:first, :conditions => ["store_id = ?", opt[:store_id]], :order => "created_at DESC")
      
      if store_food_log.nil?
        store_food_array = []        
      else
        store_food_array = store_food_log.store_food_ids.split(",")
      end
      
      obj = nil
      if opt[:add]
        obj = opt[:add].to_s
        status << "add," << obj
        store_food_array.push(obj).uniq!
      elsif opt[:del]
        obj = opt[:del].to_s
        status << "del," << obj
        store_food_array.delete(obj)
      elsif opt[:mod]
        obj = opt[:mod].to_s
        status << "mod," << obj
        obj = obj.split(",")
        store_food_array.delete(obj[0])
        store_food_array.push(obj[1]).uniq!
      end

      store_food_ids = store_food_array.join(",")
    end

    data = {}
    data[:user_id] = user_id
    data[:store_id] = store_id
    data[:status] = status
    data[:store_food_ids] = store_food_ids
    
    log = new(data)
    if log.save
      return true
    else
      return false
    end
  end
  
end
