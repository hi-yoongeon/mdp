# == Schema Information
# Schema version: 20110316100624
#
# Table name: store_tags
#
#  id         :integer         not null, primary key
#  tag_id     :integer         not null
#  store_id   :integer         not null
#  count      :integer         default(0), not null
#  sequence   :integer
#  created_at :datetime
#  updated_at :datetime
#

class StoreTag < ApplicationModel#ActiveRecord::Base
  belongs_to :tag, :class_name => "Tag", :foreign_key => "tag_id"
  belongs_to :store, :class_name => "Store", :foreign_key => "store_id"
  
  validates_presence_of :tag_id, :store_id
  validates_uniqueness_of  :tag_id, :scope => [:store_id]
  

  def self.generate(arg = {})
    tag_id = arg[:tag_id]
    store_id = arg[:store_id]
    storeTag = find(:first, :conditions => ["tag_id = ? AND store_id = ?", tag_id, store_id])
    if storeTag.nil?
      storeTag = new(:tag_id => tag_id, :store_id => store_id)
      return false unless storeTag.save
    else
      storeTag.update_attribute(:count, storeTag.count + 1)
    end
    return true
  end
end





  
