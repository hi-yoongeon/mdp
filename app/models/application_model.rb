class ApplicationModel < ActiveRecord::Base
  self.abstract_class = true
  DATE = [:created_at, :updated_at]
  DEFAULT = [:id]


  def self.attr_render(attrs = {})
    @attr_public = attrs[:public] if attrs[:public]
    @attr_private = attrs[:private] if attrs[:private]
  end
  
  def self.attr_public
    @attr_public
  end

  def self.attr_private
    @attr_private
  end

  def as_json(options = {})
    options[:show] = :default if options[:show].nil?

    json = {}
    attributes = DEFAULT
    
    options[:show] = [options[:show]] unless options[:show].is_a?(Array)
    for mode in options[:show]
      case mode.to_sym
      when :private
        attributes += self.class.attr_private
      when :public
        attributes += self.class.attr_public
      when :date
        attributes += DATE
      when :all
        attributes = self.class.column_names.map {|attr| attr.to_sym}
      end
    end


    options[:except] = [options[:except]] unless options[:except].is_a?(Array)
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


   def to_xml(options = {}, &block)
     super
   end
   
end
