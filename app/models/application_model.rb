# -*- coding: utf-8 -*-
class ApplicationModel < ActiveRecord::Base
  after_create :update_sequence   
  
  self.abstract_class = true
  
  @@like_objects = ["Store", "StoreFood", "Post"]
  @@bookmark_objects = ["Store"]  

  def self.attr_private(*attrs)
    @attr_private = attrs
  end

  def self.attr_private_all
    @attr_private = self.column_names.map(&:to_sym)
  end
  
  def self.get_attr_private
    return [] if @attr_private.nil?
    @attr_private
  end

  
  def self.has_many(association, options = {})
    options[:limit] = 5 if options[:limit].nil?
    options[:order] = "sequence ASC" if options[:order].nil?
    super(association, options)
  end
  

  def resource_owner?(resource, current_user)
    return false if current_user.nil?
    
    case resource.class.to_s
    when "User"
      return resource[:id] == current_user.id
    when "Message"
      return (resource[:received_user_id] == current_user.id) || (resource[:sent_user_id] == current_user.id)
    else 
      return resource[:user_id] == current_user.id
    end
  end
  
  def as_json(options)
    if options.nil? 
      options = {}
    end

    json = {}
    attributes = self.class.column_names.map(&:to_sym)
    
    if options[:except].nil?
      options[:except] = []
    else
      options[:except] = [options[:except]] unless options[:except].is_a?(Array)
      options[:except].map!(&:to_s)
    end
    
    if options[:include]
      unless options[:include].is_a?(Array)
        options[:include] = [options[:include]]
      end
      
      for model in options[:include]
        opt = {}
        opt[:auth] = options[:auth]
        opt[:except] = []
        for attr in options[:except]
          temp = attr.split(".")
          if temp.size == 2 && temp.first == model.to_s
            opt[:except] += [temp.second]
          end
        end
        
        options[:except] -= opt[:except]
        
        begin
          opt[:include] = [:attach_file] if model == :store
          ret = self.method(model).call.as_json(opt)
          if !ret.empty? and !ret.first.empty?
            json[model.to_s] = ret
          else
            json[model.to_s] = nil
          end      
          
        rescue Exception => e
        end

      end
    end
    
    

    obj = self.class.to_s
    if @@like_objects.include?(obj) 
      json[:like] = false
      if options[:auth]
        user = options[:auth]
        like_count = Like.count(:conditions => {:user_id => user.id, :object => obj, :foreign_key => self.id})
        json[:like] = true if like_count > 0
      end
    end
    
    
    if @@bookmark_objects.include?(obj)
      json[:bookmark] = false
      if options[:auth]
        user = options[:auth]
        bookmark_count = Bookmark.count(:conditions => {:user_id => user.id, :object => obj, :foreign_key => self.id})
        json[:bookmark] = true if bookmark_count > 0
      end
    end

    if obj == "User"
      json[:following] = false
      json[:followed] = false
      if options[:auth]
        user = options[:auth]
        is_following = Following.count(:conditions => {:following_user_id => user.id, :followed_user_id => self.id})
        is_followed = Following.count(:conditions => {:following_user_id => self.id, :followed_user_id => user.id})
        json[:following] = true if is_following > 0
        json[:followed] = true if is_followed > 0
      end
    end

    options[:except].map!(&:to_sym)
    if !resource_owner?(self, options[:auth])
      options[:except] += self.class.get_attr_private
    else

    end
    
    attributes -= options[:except]
    keys = self.attributes.keys
    
    for attr in attributes
      if keys.include?(attr.to_s)
        json[attr] = self[attr]
      end
    end


    # 전화번호 규칙성이 없어서 임시로 만들어놨음..
    if json[:tel] and json[:tel].length > 0
      if json[:tel] != /[0-9]/
        json[:tel].gsub!(/[,\.].*/, '')
        json[:tel].gsub!(/[^0-9]/, '')
      end
    end
    
    return json
  end  

  private
  def update_sequence
    update_attribute(:sequence, id * -1)
  end  
end
