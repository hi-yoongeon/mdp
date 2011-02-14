class Notice < ActiveRecord::Base

  validates_presence_of :subject, :content, :target, :start_date, :end_date
  
  
end
