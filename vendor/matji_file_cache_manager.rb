class MatjiFileCacheManager

  def initialize(id)
    Dir.chdir(Rails.root.to_s << '/public')
  end


  def add_img(img)
    timestamp = Time.new.to_i
    filename = @path + "/img_original/#{timestamp}"
    File.new(filename, "w") unless File.exist? filename
    File.open(filename, "wb") do |f|
      f.write img.read
    end

    require 'RMagick'

    thum_img = Magick::ImageList.new("#{@path}/img_original/#{timestamp}")
    thum_img.resize!(48,48)
    thum_img.write("#{@path}/img_thumbnail/#{timestamp}")
  end


  def img_path(opt={})
    filename = @path + "/img_thumbnail"
    Dir.chdir(filename)
    img = Dir.glob("*").max
    Dir.chdir(Rails.root.to_s)
    
    if (opt[:fullpath] == true)
      path = @path + "/img_thumbnail/" + img
    else
      path = @webPath + "/img_thumbnail/" + img
    end
    return path
  end



  def make_file_cache_dir
    ud = @webPath.split("/")
    File.umask(0)
    ud.each do |w| 
      unless w == ""
        Dir.mkdir(w, 0777) unless Dir.exist? w
        Dir.chdir(w)
      end
    end
    Dir.mkdir("img_original") unless Dir.exist? "img_original"
    Dir.mkdir("img_thumbnail") unless Dir.exist? "img_thumbnail"
    Dir.chdir(Rails.root.to_s)
  end


end
