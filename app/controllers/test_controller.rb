class TestController < ApplicationController

  def test    
    require "matji_file_cache_manager"
    
    
    mfcm = MatjiFileCacheManager.new(100000002)
    
    mfcm.add_follower(10000002) 
    # mfcm.add_follower(10000003)
    # mfcm.add_follower(10000004)
    # mfcm.add_follower(10000005)
    # mfcm.add_follower(100000234)
    # mfcm.add_follower(100023234002)
    # mfcm.add_follower(1000001231132)
    t = mfcm.follower


    render :text => t
    
    
    
    

 #   render :text => RAILS_ROOT
  end

end
