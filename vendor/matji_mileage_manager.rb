# -*- coding: utf-8 -*-

XML_FILE = "vendor/rules.xml"

require 'rexml/document'
include REXML

class MatjiMileageManager
  attr_accessor :controller_name, :action_name
  
  def initialize(user_id)
    @user_id = user_id
    load_xml
  end

  def act(controller_name, action_name)
    
  end


  private
  def load_xml()
    filepath = File.join(Rails.root.to_s, XML_FILE)

    f = File.open(filepath)
    rule_xml = Document.new(f)
  end

  
  def saveMyMileage()
    self.insertDB()
  end

  def saveOthersMileage()
    self.insertDB()
  end
  
  def insertDB(from_user_id, point, mode, flag)
    
    ## 실제로 디비를 입력하는 로직

  end
  
  self.singleton_methods
end

