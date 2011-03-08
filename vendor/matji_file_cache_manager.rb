class MatjiFileCacheManager

  def initialize(user_id)
    Dir.chdir(Rails.root.to_s << '/public')
    @user_id = user_id.to_s
    @user_webPath = user_dir
    @user_path = "public/" + @user_webPath

    make_file_cache_dir unless Dir.exist? @user_path
  end


  def add_follower(user_id)
    filename = @user_path + "/follower"
    add_user(filename, user_id)
  end


  def add_following(user_id)
    filename = @user_path + "/following"
    add_user(filename, user_id)
  end


  def remove_follower(user_id)
    filename = @user_path + "/follower"
    remove_user(filename, user_id)
  end  


  def remove_following(user_id)
    filename = @user_path + "/following"
    remove_user(filename, user_id)
  end  


  def add_profile_img(img)
    timestamp = Time.new.to_i
    filename = @user_path + "/profile_img_original/#{timestamp}"
    File.new(filename, "w") unless File.exist? filename
    File.open(filename, "wb") do |f|
      f.write img.read
    end    
    require 'RMagick'
    thum_img = Magick::ImageList.new("#{@user_path}/profile_img_original/#{timestamp}")
    thum_img.resize!(48,48)
    thum_img.write("#{@user_path}/profile_img_thumnail/#{timestamp}")
  end


  def follower
    filename = @user_path + "/follower"
    line = ""
    line = IO.readlines(filename)[0] if File.exist?(filename)
  end


  def following
    filename = @user_path + "/following"
    line = ""
    line = IO.readlines(filename)[0] if File.exist?(filename)
  end


  def profile_img
    filename = @user_webPath + "/profile_img_thumnail"
    Dir.chdir(filename)
    img = "/" + Dir.glob("*").max
    img_path = filename + img
  end


  private
  
  def add_user(filename, user_id)
    if File.exist? filename
      text = IO.readlines(filename)[0]
    end
    
    text = "" if text.nil?

    arr = text.split(",")

    arr.push(user_id.to_s).uniq!

    File.open(filename, "w") { |f| 
      f.syswrite(arr.join(","))
    }
  end


  def remove_user(filename, user_id)

    if File.exist? filename
      text = IO.readlines(filename)[0]
    end
    
    text = "" if text.nil?
    
    arr = text.split(",")
    arr.delete(user_id.to_s)
    
    File.open(filename, "w") { |f| 
      f.syswrite(arr.join(","))
    }

  end


  def user_dir
    "file_cache/user/" + @user_id[0..1]+"/"+@user_id[2..3]+"/"+@user_id[4..5]+"/"+@user_id[6..7]+"/"+@user_id[8..9]
  end


  def make_file_cache_dir
    ud = user_dir.split("/")
    File.umask(0)
    ud.each do |w| 
      unless w == ""      
        Dir.mkdir(w, 0777) unless Dir.exist? w
        Dir.chdir(w)
      end
    end
    Dir.mkdir("profile_img_original") unless Dir.exist? "profile_img_original"
    Dir.mkdir("profile_img_thumnail") unless Dir.exist? "profile_img_thumnail"
    Dir.chdir(Rails.root.to_s)
  end


end
