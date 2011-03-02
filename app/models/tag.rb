class Tag < ApplicationModel#ActiveRecord::Base
  has_many :post_tags, :dependent => :destroy
  has_many :user_tags, :dependent => :destroy
  has_many :store_tags, :dependent => :destroy
  
  validates_presence_of :tag
  validates_uniqueness_of :tag
  
  def self.generate(arg = {:tags => nil, :user_id => nil, :post_id => nil})
    tags = arg[:tags].split(",").map {|tag| tag.strip}
    user_id = arg[:user_id]
    post_id = arg[:post_id]
    
    for tag in tags
      t = find_by_tag(tag)

      if t.nil?
        t = new(:tag => tag)
        return false unless t.save
      end

      UserTag.generate(:user_id => user_id, :tag_id => t.id)
      PostTag.generate(:post_id => post_id, :tag_id => t.id)
      post = Post.find(post_id)
      unless post.store_id.nil?
        StoreTag.genertae(:store_id => post.store_id, :tag_id => t.id)
      end
    end
    


    return true
  end

end
