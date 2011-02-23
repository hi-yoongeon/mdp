class ApplicationModel < ActiveRecord::Base
  self.abstract_class = true
  DATE = [:created_at, :updated_at]
  DEFAULT = [:id]


  def self.attr_render(attrs = {})
    if attrs[:private] 
      if attrs[:private].is_a?(Array)
        @attr_private = attrs[:private]
      else
        @attr_private = [attrs[:private]]         
      end
    end
  end
  
  def self.attr_private
    @attr_private
  end

  def resource_owner?(resource, current_user)
    return false if current_user.nil?
    
    case resource.class
    when User
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
    
    if !self.class.attr_private.nil? and !resource_owner?(self, options[:auth])
      options[:except] += self.class.attr_private
    end

    attributes -= options[:except]
    
    for attr in attributes
      json[attr] = self[attr]
    end
    
    
    if options[:include]
      #assoc_json = super(options)
      unless options[:include].is_a?(Array)
        options[:include] = [options[:include]]
      end
      
      for model in options[:include]
        #json[model.to_s] = assoc_json["post"][model]
        opt = options.clone
        opt.delete(:include)
        json[model.to_s] = self.method(model).call.as_json(opt)
      end
    end
    
    return json
  end  

end
