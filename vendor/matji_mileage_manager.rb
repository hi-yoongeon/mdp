# -*- coding: utf-8 -*-

RULE_XML_FILE = "vendor/mileage_config/rule.xml"

require 'rexml/document'
include REXML

class MatjiMileageManager
  
  attr_accessor :from_user_id

  def initialize(user_id)
    @from_user_id = user_id
    load_xml
  end

  def act(controller_name, action_name)

    begin

      result = Array.new()

      root = @rule_xml.root
      elem = root.elements["controller[@name='"+controller_name+"']"]
      elem = elem.elements["action[@name='"+action_name+"']"]
      elem = elem.elements
      elem.each("mileage") do | element |      
        r = Hash.new()
        r[:flag] = element.attributes['flag']
        r[:point] = element.attributes['point']
        r[:to] = (element.attributes['to'].nil?) ? "me" : element.attributes['to']
        result.push(r)
      end

    rescue
      result = nil
    end

    result
  end





  def error
    raise NameError, "define @mmm_user_id variable for accumulating mileage in controller"
  end
  
  private
  def load_xml()
    filepath = File.join(Rails.root.to_s, RULE_XML_FILE)

    f = File.open(filepath)
    @rule_xml = Document.new(f)
  end  

end

