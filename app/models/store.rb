class Store < ApplicationModel
  has_many :posts, :dependent => :nullify
  has_many :activities
  has_many :store_foods, :dependent => :destroy
  has_one :attach_file
  has_many :likes, :conditions => {:object => "Store"}, :foreign_key => "foreign_key"
  has_many :bookmarks, :conditions => {:object => "Store"}, :foreign_key => "foreign_key"
  has_many :store_tags, :order => "count DESC"
  has_many :tags, :through => :store_tags
  has_many :foods, :through => :store_foods
  has_many :urls, :class_name => "StoreUrl", :foreign_key => "store_id"
  has_one :store_detail_info, :dependent => :destroy, :order => "id ASC"
  belongs_to :user, :class_name => "User", :foreign_key => "reg_user_id"
  
  validates_presence_of :name, :address, :lat, :lng
  attr_accessor :user_id
  
  before_save :validates_tel_format
  before_save :first_store_regist
  after_save :mileage_for_store_regist

  define_index do
    # fields
    indexes name
    indexes address
    indexes tags.tag, :as => :tag_name
    indexes foods.name, :as => :food_name
    #set_property :enable_star => 1
    set_property :min_infix_len => 2
    
    # attributes
    has like_count, sequence
  end

  
  # def user_id=(id)
  # end
  
  private
  def first_store_regist
    if self.reg_user_id.nil? and self.user_id
      self.reg_user_id = self.user_id
      @is_mileage_apply = true
    end
    return true
  end


  def mileage_for_store_regist
    #if @is_mileage_apply == true
      # require "matji_mileage_manager"
      # mmm = MatjiMileageManager.new(self.user_id)
      # mmm.act("stores", "register")
    #end
  end
  
  def validates_tel_format
    if self.tel and self.tel.length > 0
      if self.tel != /[0-9]+/
        self.tel.gsub!(/[,\.].*/, '')
        self.tel.gsub!(/[^0-9]/, '')
      end
    end

    return true
  end


end
