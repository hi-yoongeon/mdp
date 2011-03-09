require "matji_file_cache_manager"
class AttachFileCacheManager < MatjiFileCacheManager

  def initialize(id)
    super
    @webPath = file_dir(id)
    @path = "public/" + @webPath

    make_file_cache_dir unless Dir.exist? @path
  end



  def file_dir(id)
    id = id.to_s
    dir = "file_cache/file/"
    
    id.split("").each do |d|
      dir << d << "/"
    end
    dir[dir.size-1] = ""
    return dir
  end

  


end
