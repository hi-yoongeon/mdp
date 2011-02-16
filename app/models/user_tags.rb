class UserTags < ActiveRecord::Base
  belongs_to :tag, :classname => "Tag", :foreign_key => "tag_id"
  belongs_to :user, :classname => "User", :foreign_key => "user_id"

  validates_presence_of :tag_id, :user_id
end
