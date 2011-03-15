require "matji_file_cache_manager"

class UserFileCacheManager < MatjiFileCacheManager

  def initialize(user_id)
    super

    @webPath = user_dir(user_id)
    @path = "public/" + @webPath
    
    make_file_cache_dir unless File.exist? @path
  end


  def add_follower(user_id)
    filename = @path + "/follower"
    add_user(filename, user_id)
  end


  def add_following(user_id)
    filename = @path + "/following"
    add_user(filename, user_id)
  end


  def remove_follower(user_id)
    filename = @path + "/follower"
    remove_user(filename, user_id)
  end  


  def remove_following(user_id)
    filename = @path + "/following"
    remove_user(filename, user_id)
  end  


  def follower
    filename = @path + "/follower"
    line = ""
    line = IO.readlines(filename)[0] if File.exist?(filename)
  end


  def following
    filename = @path + "/following"
    line = ""
    line = IO.readlines(filename)[0] if File.exist?(filename)
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

  
  def user_dir(user_id)
    user_id = user_id.to_s
    return "file_cache/user/" + user_id[0..1]+"/"+user_id[2..3]+"/"+user_id[4..5]+"/"+user_id[6..7]+"/"+user_id[8..9]
  end

end
