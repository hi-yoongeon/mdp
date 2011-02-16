class PostTags < ActiveRecord::Base
  belongs_to :tag, :class_name => "Tag", :foreign_key => "tag_id"
  belongs_to :post, :class_name => "Post", :foreign_key => "post_id"

  validates_presence_of :tag_id, :post_id

end
