class StoreTags < ActiveRecord::Base
  belongs_to :tag, :class_name => "Tag", :foreign_key => "tag_id"
  belongs_to :store, :class_name => "Store", :foreign_key => "store_id"
  
  validates_presence_of :tag_id, :store_id

end
