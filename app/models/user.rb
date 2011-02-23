class User < ApplicationModel#ActiveRecord::Base
  
  has_one :user_extra_info, :dependent => :destroy
  has_many :clients, :dependent => :destroy
  has_many :access_grants, :dependent => :destroy
  has_many :likes, :dependent => :destroy
  has_many :bookmarks, :dependent => :destroy
  has_many :posts, :dependent => :nullify
  has_many :attach_files, :dependent => :nullify
  has_many :stores, :dependent => :nullify, :class_name => "Store", :foreign_key => "reg_user_id"
  has_many :activities, :dependent => :nullify
  has_many :sent_messages, :dependent => :nullify, :class_name => "Message", :foreign_key => "sent_user_id"
  has_many :received_messages, :dependent => :nullify, :class_name => "Message", :foreign_key => "received_user_id"  
  has_many :followings, :dependent => :destroy, :class_name => "Following" ,:foreign_key => "following_user_id"
  has_many :followeds, :dependent => :destroy, :class_name => "Following", :foreign_key => "followed_user_id"
  has_many :user_external_accounts, :dependent => :destroy
  has_many :tags, :class_name => "UserTag", :foreign_key => "user_id",  :dependent => :destroy

  validates_length_of :userid, :within => 4..20
  validates_length_of :password, :within => 4..20
  validates_length_of :nick, :within => 1..20
  validates_presence_of :userid, :email, :nick, :password, :password_confirmation, :salt
  validates_uniqueness_of :userid, :email
  validates_confirmation_of :password
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Invalid email"
  attr_protected :id, :salt
  attr_accessor :password, :password_confirmation

  attr_render :private => [:salt, :hashed_password, :email]

 
  def self.authenticate(userid, pass)
   user = find(:first, :conditions=>["userid = ?", userid])
    return nil if user.nil?
    return user if User.encrypt(pass, user.salt) == user.hashed_password
    nil
  end  

  def password=(pass)
    @password=pass
    self.salt = AccessGrant.random_string(10) if !self.salt?
    self.hashed_password = User.encrypt(@password, self.salt)
  end


  def send_new_password
    new_pass = AccessGrant.random_string(10)
    self.password = self.password_confirmation = new_pass
    self.save
    Notifications.deliver_forgot_password(self.email, self.login, new_pass)
  end

  protected
  def self.encrypt(pass, salt)
    Digest::SHA1.hexdigest(pass + salt)
  end


end
