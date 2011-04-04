class AttachFile < ApplicationModel
  belongs_to :user, :class_name => "User", :foreign_key => "user_id" 
  belongs_to :store, :class_name => "Store", :foreign_key => "store_id"
  belongs_to :post, :class_name => "Post", :foreign_key => "post_id"
  validates_presence_of :user_id, :fullpath, :filename

  after_create :increase_image_count
  before_destroy :decrease_image_count
  
  private
  def increase_image_count
    if self.store_id
      Store.update_all("image_count = image_count + 1", "id = #{self.store_id}")
    end
    if self.post_id
      Post.update_all("image_count = image_count + 1", "id = #{self.post_id}")
    end
  end

  def decrease_image_count
    if self.store_id
      Store.update_all("image_count = image_count - 1", "id = #{self.store_id}")
    end
    if self.post_id
      Post.update_all("image_count = image_count - 1", "id = #{self.post_id}")
    end
  end
  
end
