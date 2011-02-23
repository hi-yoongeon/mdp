module ModelHelper
  module Renderable
    def self.attr_renderable(options = {})
      @public = options[:public] if options[:public]
      @private = options[:private] if options[:private]
    end
  end
end
