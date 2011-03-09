class TestController < ApplicationController
  
  def test
    require "user_file_cache_manager"
    mfcm = UserFileCacheManager.new(100000002)
    mfcm.add_follower(params[:friend_id]) 
    t = mfcm.follower
    render :text => t
 #   render :text => RAILS_ROOT
  end

  def test2
    require "user_file_cache_manager"
    mfcm = UserFileCacheManager.new(100000002)
    mfcm.remove_follower(params[:friend_id])
    t = mfcm.follower
    render :text => t
  end


  def upload

    require "attach_file_cache_manager"
    mfcm = AttachFileCacheManager.new(12342)
    uploaded_file = params[:upload_file]

    unless params[:upload_file].nil?
      mfcm.add_img(uploaded_file)
      @img = mfcm.img_path
    end
    render

  end


end
