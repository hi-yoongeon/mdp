class TestController < ApplicationController
  before_filter :login_required, :except => [:test, :upload]

  def test
    require "matji_file_cache_manager"
    mfcm = MatjiFileCacheManager.new(100000002)
    
    mfcm.add_follower(10000002) 
    t = mfcm.follower

    render :text => t    
 #   render :text => RAILS_ROOT
  end


  def upload
    uploaded_file = params[:upload_file]
<<<<<<< HEAD
    
    puts uploaded_file.read


    # unless uploaded_file.nil? do

    #     require "matji_file_cache_manager"
        
    #     mfcm = MatjiFileCacheManager.new(100000002)
    #     mfcm.add_profile_img(uploaded_file)

    #   end







=======
    require "matji_file_cache_manager"
    mfcm = MatjiFileCacheManager.new(100000002)
    mfcm.add_profile_img(uploaded_file)
>>>>>>> 0605ccc8fb922cd5de2c8b96762a55fd91a78042
  end
end
