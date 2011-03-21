class DummyDbsController < ApplicationController
respond_to :html

  def index

  end

  def user_mileage
    1000.times do |i|
      user_id = Random.new.rand(100000001..100000100)
      total_point = Random.new.rand(1..10)

      um = UserMileage.find_by_user_id(user_id)

      if um.nil?
        UserMileage.create(
                          :user_id => user_id, 
                          :total_point => total_point, 
                          :grade => nil, 
                          :special_user => "false", 
                          :blacklist_user => "false"
                          )

      else
        um_total_point = total_point + um[:total_point];
        um.save(:total_point => um_total_point)
      end
      
      sleep 1
    end
    @success = "Success making dummy!!"    
    render :action => 'index'
#    redirect_to '/dummy'

  end

  def test

  end

end
