class StoreUrl < ApplicationModel
  has_one :user
  has_one :store
  
  validates_presence_of :user_id, :store_id, :url
end
