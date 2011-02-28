# -*- coding: utf-8 -*-

class MatjiFileCacheManager

  def initialize(user_id)
    Dir.chdir("..");
    @user_id = user_id.to_s
    @base_path = Dir.getwd
    @full_path = user_dir

    make_file_cache_dir unless Dir.exist? @full_path
  end


  def add_follower(user_id)
    filename = @full_path + "/follower"
    File.new(filename, "w") unless File.exist? filename    
    File.open(filename, "a") do |file|
      file << user_id.to_s + "," 
    end
  end


  def add_following(user_id)
    filename = @full_path + "/following"
    File.new(filename, "w") unless File.exist? filename
    File.open(filename, "a") do |file|
      file << user_id.to_s + ","
    end
  end

  def remove_follower(user_id)
    filename = @full_path + "/follower"
    File.rename filename, filename+".bak"
    old_file = File.open(filename+".bak")
    new_file = File.open(filename, "w")
    while line = old_file.gets do
      remove = line.gsub(/#{user_id},/, "")
      new_file.write(remove)
    end
  end  

  def remove_following(user_id)
    filename = @full_path + "/following"
    File.rename filename, filename+".bak"
    old_file = File.open(filename+".bak")
    new_file = File.open(filename, "w")
    while line = old_file.gets do
      remove = line.gsub(/#{user_id},/, "")
      new_file.write(remove)
    end
  end  

  def add_profile_img(img)
    filename = @full_path + "/#{img}.jpg"
    File.new(filename, "w") unless File.exist? filename
    
  end

  def follower
    filename = @full_path + "/follower"
    File.open(filename).each { |line| puts line}
  end

  def following
    filename = @full_path + "/following"
    File.open(filename).each { |line| puts line}
  end

  def profile_img
    filename = @full_path + "/image"
  end



  
  private

  def user_dir
    @base_path + "/file_cache/user/" + @user_id[0..1]+"/"+@user_id[2..3]+"/"+@user_id[4..5]+"/"+@user_id[6..7]+"/"+@user_id[8..9]
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

mfcm = MatjiFileCacheManager.new(100000004)
#mfcm.add_profile_img(123)
#mfcm.remove_follower(100000005)

