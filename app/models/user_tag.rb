class UserTag < ActiveRecord::Base
  belongs_to :tag, :class_name => "Tag", :foreign_key => "tag_id"
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"

  validates_presence_of :tag_id, :user_id
  validates_uniqueness_of  :tag_id, :scope => [:user_id]

  def self.generate(arg = {})
    tag_id = arg[:tag_id]
    user_id = arg[:user_id]
    userTag = find(:first, :conditions => ["tag_id = ? AND user_id = ?", tag_id, user_id])
    if userTag.nil?
      userTag = new(:tag_id => tag_id, :user_id => user_id)
      return false unless userTag.save
    else
      userTag.update_attribute(:count, userTag.count + 1)
    end
    return true
  end
  
end
