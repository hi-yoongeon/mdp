class ApplicationModel < ActiveRecord::Base
  self.abstract_class = true

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
        opt[:except] = []
        for attr in options[:except]
          temp = attr.split(".")
          if temp.size == 2 && temp.first == model.to_s
            opt[:except] += [temp.second]
          end
        end

        options[:except] -= opt[:except]
        
        ret = self.method(model).call.as_json(opt)
        if !ret.empty? and !ret.first.empty?
          json[model.to_s] = ret
        end
      end
    end

    options[:except].map!(&:to_sym)
    unless resource_owner?(self, options[:auth])
      options[:except] += self.class.get_attr_private
    end
    attributes -= options[:except]
    for attr in attributes
      json[attr] = self[attr]
    end
    
    

    
    return json
  end  

  
end
