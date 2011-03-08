class TestController < ApplicationController
  
  def test
    require "matji_file_cache_manager"
    mfcm = MatjiFileCacheManager.new(100000002)
    mfcm.add_follower(params[:friend_id]) 
    t = mfcm.follower
    render :text => t
 #   render :text => RAILS_ROOT
  end

  def test2
    require "matji_file_cache_manager"
    mfcm = MatjiFileCacheManager.new(100000002)
    mfcm.remove_follower(params[:friend_id])
    t = mfcm.follower
    render :text => t
  end


  def upload

    require "matji_file_cache_manager"
    mfcm = MatjiFileCacheManager.new(100000002)
    uploaded_file = params[:upload_file]

    unless params[:upload_file].nil?
      mfcm.add_profile_img(uploaded_file)
      @img = mfcm.profile_img
    end
    render

  end


end
