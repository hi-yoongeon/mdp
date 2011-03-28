class StoreDetailInfoLog < ApplicationModel
  belongs_to :store
  belongs_to :user
  
  
  validates_presence_of :store_id, :user_id, :status

  protected
  def self.logging(opt = {})
    user_id = opt[:user_id]
    store_id = opt[:store_id]
    status = ""
    if opt[:add]
      status << "add," << opt[:add].to_s
    elsif opt[:mod]
      status << "mod," << opt[:mod].to_s
    elsif opt[:rb]
      status << "rb," << opt[:rb].to_s
    end
    
    data = {}
    data[:user_id] = user_id
    data[:store_id] = store_id
    data[:status] = status
    
    log = new(data)
    if log.save
      return true
    else
      return false
    end
  end
end
