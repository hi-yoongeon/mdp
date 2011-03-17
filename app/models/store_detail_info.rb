class StoreDetailInfo < ActiveRecord::Base
  belongs_to :store
  belongs_to :user
  
  
  validates_presence_of :user_id, :store_id, :note
  
  
end
