class StoreFoodLog < ApplicationModel
  belongs_to :store
  belongs_to :user
  
  validates_presence_of :store_id, :user_id, :action, :food_name
  validates_inclusion_of :action, :in => %w(Add Delete)


  
end
