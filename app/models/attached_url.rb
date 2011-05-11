class AttachedUrl < ApplicationModel
  belongs_to :user
  belongs_to :store

  validates_presence_of :user_id, :url

end
