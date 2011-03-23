# -*- coding: utf-8 -*-

RULE_XML_FILE = "vendor/mileage_config/rule.xml"
GRADE_XML_FILE = "vendor/mileage_config/grade.xml"

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

      root = @xml.root
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


#   def calculate_grade
#     load_xml("grade")

  
#     total_count = UserMileage.count(:conditions => "total_point > 0 and special_user = 'f' and blacklist_user = 'f'")

#     ascending_ordered_user = UserMileage.find(:all, :order => 'total_point', limit => )

#     a = 5
#     num_of_a = (total_count * (a/100.0)).to_i
#     b = 10
#     num_of_b = (total_count * (b/100.0)).to_i
#     c = 20
#     num_of_c = (total_count * (c/100.0)).to_i
#     d = 50
#     num_of_d = (total_count * (d/100.0)).to_i
#     e = 100
#     num_of_e = (total_count * (e/100.0)).to_i
    
#     root = @xml.root


    
#   end


  def error
    raise NameError, "define @mmm_user_id variable for accumulating mileage in controller"
  end
  
  private
  def load_xml(type = "rule")
    if type == "rule"
      filepath = File.join(Rails.root.to_s, RULE_XML_FILE)
    elsif type == "grade"
      filepath = File.join(Rails.root.to_s, GRADE_XML_FILE)
    end

    f = File.open(filepath)
    @xml = Document.new(f)
  end  
    
end
