class ModifyRequestedStore < ApplicationModel
  belongs_to :user
  validates_presence_of :name, :address, :lat, :lng, :user_id, :store_id
end
