class ApplicationModel < ActiveRecord::Base
  self.abstract_class = true
  DATE = [:created_at, :updated_at]
  DEFAULT = [:id]


  def self.attr_private(*attrs)
    @attr_private = attrs
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
    attributes = self.class.column_names.map {|attr| attr.to_sym}
    
    options[:except] = [] unless options[:except]
    options[:except] = [options[:except]] unless options[:except].is_a?(Array)
    
    unless resource_owner?(self, options[:auth])
      options[:except] += self.class.get_attr_private
    end

    attributes -= options[:except]
    
    for attr in attributes
      json[attr] = self[attr]
    end
    
    
    if options[:include]
      unless options[:include].is_a?(Array)
        options[:include] = [options[:include]]
      end
      
      for model in options[:include]
        opt = options.clone
        opt.delete(:include)
        json[model.to_s] = self.method(model).call.as_json(opt)
      end
    end
    
    return json
  end  

end
