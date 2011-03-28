class MatjiFileCacheManager

  def initialize(id)
    Dir.chdir(Rails.root.to_s << '/public')
  end


  def add_img(img)
    timestamp = Time.new.to_i
    @filename = Digest::MD5.hexdigest(timestamp.to_s + @path)
    filepath = @path + "/img_original/#{@filename}"
    
    while File.exist? filepath do
      @filename = Digest::MD5.hexdigest(@filename)
      filepath = @path + "/img_original/#{@filename}"
    end
    

    File.open(filepath, "wb") do |f|
      f.write img.read
    end

    require 'RMagick'

    thum_img = Magick::ImageList.new("#{@path}/img_original/#{@filename}")
    thum_img.resize!(128,128)
    thum_img.write("#{@path}/img_thumbnail_m/#{@filename}")
    thum_img.resize!(48,48)
    thum_img.write("#{@path}/img_thumbnail_s/#{@filename}")
    
  end


  def img_filename
    return @filename
  end
  

  def img_path()
    return @path + "/"
  end



  def make_file_cache_dir
    ud = @webPath.split("/")
    File.umask(0)
    ud.each do |w| 
      unless w == ""
        Dir.mkdir(w, 0777) unless File.exist? w
        Dir.chdir(w)
      end
    end
    
    Dir.mkdir("img_original") unless File.exist? "img_original"
    Dir.mkdir("img_thumbnail_s") unless File.exist? "img_thumbnail_s"
    Dir.mkdir("img_thumbnail_m") unless File.exist? "img_thumbnail_m"
    Dir.chdir(Rails.root.to_s)
  end


end
