class ApplicationModel < ActiveRecord::Base
  after_create :update_sequence   
  
  self.abstract_class = true
  @@like_objects = ["Store", "StoreFood", "Post"]    

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

  def resource_owner?(resource, current_user)
    return false if current_user.nil?
    
    case resource.class.to_s
    when "User"
      return resource[:id] == current_user.id
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
      if options[:auth]
        user = options[:auth]
        like = Like.find(:first, :conditions => {:user_id => user.id, :object => self.class.to_s, :foreign_key => self.id})
        if like
          json[:like] = true
        else
          json[:like] = false
        end
      else
        json[:like] = false
      end
    end
    
    options[:except].map!(&:to_sym)
    if !resource_owner?(self, options[:auth])
      options[:except] += self.class.get_attr_private
    else

    end
    
    attributes -= options[:except]
    for attr in attributes
      json[attr] = self[attr]
    end
    
    return json
  end  

  private
  def update_sequence
    update_attribute(:sequence, id * -1)
  end  
end
