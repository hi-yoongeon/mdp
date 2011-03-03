# -*- coding: utf-8 -*-

class MatjiFileCacheManager

  def initialize(user_id)
    Dir.chdir(Rails.root.to_s)
    @user_id = user_id.to_s
    @user_path = user_dir
    make_file_cache_dir unless Dir.exist? @user_path
  end


  def add_follower(user_id)
    filename = @user_path + "/follower"
    File.new(filename, "w") unless File.exist? filename    
    add_user(filename, user_id)
  end


  def add_following(user_id)
    filename = @user_path + "/following"
    File.new(filename, "w") unless File.exist? filename
    add_user(filename, user_id)
  end

  def remove_follower(user_id)
    filename = @user_path + "/follower"
    remove_user(filename, user_id)
  end  

  def remove_follower(user_id)
    filename = @user_path + "/follower"
    File.open(filename,"w")
    remove_user(filename, user_id)
  end  


  def remove_following(user_id)
    filename = @user_path + "/following"
    File.open(filename,"w")
    remove_user(filename, user_id)
  end  


  def add_profile_img(img)
    ori_img_path = "#{@user_path}/profile_img_original" 
    thum_img_path = "#{@user_path}/profile_img_thumbnail"
    Dir.mkdir(ori_img_path) unless Dir.exist? ori_img_path
    Dir.mkdir(thum_img_path) unless Dir.exist? thum_img_path
    timestamp = Time.new.to_i
    filename = ori_img_path + "/#{timestamp}"
    File.new(filename, "w") unless File.exist? filename
    File.open(filename, "wb") do |f|
      f.write img.read
    end    
    require 'RMagick'
    include Magick
    thum_img = ImageList.new("#{ori_img_path}/#{timestamp}")
    thum_img.resize!(48,48)
    thum_img.write("#{thum_img_path}/#{timestamp}")
  end

  def follower
    filename = @user_path + "/follower"
    File.open(filename).each { |line| $str = line}
    $str
  end


  def following
    filename = @user_path + "/following"
    File.open(filename).each { |line| puts line}
  end


  def profile_img
    filename = @user_path + "/image"
  end

  private

  def add_user(filename, user_id)
    arr = Array.new()
    File.open(filename, "r") do |f|
      unless (text = f.read.chomp).nil? 
        arr = text.split(",")
      end
      puts arr.size
    end
    arr.push(user_id.to_s).uniq!

    File.open(filename, File::RDWR|File::TRUNC) { |f| 
      puts arr.join(",")
      f.write arr.join(",") + "\n" 
    }

  end

  def remove_user(filename, user_id)
    arr = Array.new()
    File.open(filename, "r") { |f|  arr = f.read.chomp.split(",") unless f.read.chomp.nil?  }
    arr.delete_if { |f| f = user_id}
    File.open(filename, File::RDWR|File::TRUNC) { |f| f.write arr.join(",") + "\n" }
  end

  def user_dir
    "file_cache/user/" + @user_id[0..1]+"/"+@user_id[2..3]+"/"+@user_id[4..5]+"/"+@user_id[6..7]+"/"+@user_id[8..9]
  end

  def make_file_cache_dir
    puts "#{@user_id}에 맞게 디렉토리 생성";
    ud = user_dir.split("/")

    ud.each do |w| 
      unless w == ""      
        Dir.mkdir(w) unless Dir.exist? w
        Dir.chdir(w)
      end
    end
  end


end

#Usage
#mfcm = MatjiFileCacheManager.new(100000004)
#mfcm.add_follower(100000005)
#mfcm.remove_follower(100000005)
#mfcm.add_profile_img
