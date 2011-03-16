# == Schema Information
# Schema version: 20110316100624
#
# Table name: notices
#
#  id         :integer         not null, primary key
#  subject    :string(255)     not null
#  content    :text            not null
#  target     :string(255)     not null
#  start_date :datetime        not null
#  end_date   :datetime        not null
#  sequence   :integer
#  created_at :datetime
#  updated_at :datetime
#

class Notice < ApplicationModel#ActiveRecord::Base

  validates_presence_of :subject, :content, :target, :start_date, :end_date
  
  
end
