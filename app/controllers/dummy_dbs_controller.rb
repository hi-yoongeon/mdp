class DummyDbsController < ApplicationController
respond_to :html

  def index

  end


  def user_mileage
    1000.times do |i|
      user_id = Random.new.rand(1..10)
      total_point = Random.new.rand(1..1000)

      UserMileage.create(
                         :user_id => user_id, 
                         :total_point => total_point, 
                         :grade => nil, 
                         :special_user => "false", 
                         :blacklist_user => "false"
                         )
      sleep 1
    end
    @success = "Success making dummy!!"    
    render :action => 'index'
#    redirect_to '/dummy'

  end

  def test

  end

end
