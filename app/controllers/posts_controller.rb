class PostsController < ApplicationController
  before_filter :authentication_required, :only => [:new, :delete, :like, :unlike, :my_list]
  before_filter :http_get, :only => [:show, :list, :reply_list ,:my_list, :nearby_list, :region_list, :store_list]
  before_filter :http_post, :only => [:new, :delete, :like, :unlike]
  
  respond_to :xml, :json


  def search
    if parameters_required :q
      text = params[:q]
      words = text.split(" ")
      query_text = ""
      word_size = words.size
      for i in 0 .. word_size - 1
        query_text << "("
        chars = words[i].split(//)
        char_size = chars.size
        for j in 0 .. char_size - 1
          query_text << " #{chars[j].to_s + chars[j+1].to_s} "
          if j >= char_size - 2
            break
          end
          query_text << "|"
        end
        
        query_text << ") "
        
        if i == word_size - 1
          break;
        end

      end

      options = {}
      options[:page] = params[:page] if params[:page]
      options[:per_page] = params[:limit] if params[:limit]
      options[:match_mode] = :extend
      options[:order] = "sequence ASC, @relevance DESC"
      options[:sort_mode] = :extended
      
      query_text = "#{text} | #{query_text}"
      
      ret = Post.search query_text,  options
      __respond_with ret

    end
  end


  def show
    if parameters_required :post_id
      params[:id] = params[:post_id]
      ret = __find(Post, nil, nil)
      __respond_with ret, :include => [], :except => []
    end
  end


  def new
    if parameters_required :post
      data = {}
      data[:post] = params[:post]
      data[:user_id] = current_user.id
      data[:lat] = -1 
      data[:lng] = -1
      data[:lat] = params[:lat] if params[:lat]
      data[:lng] = params[:lng] if params[:lat]

      
      # test code
      data[:from_where] = "IPHONE" if data[:from_where].nil?
      data[:from_where].upcase!
      
      
      if params[:store_id]
        data[:store_id] = params[:store_id]
        store = Store.find(params[:store_id])
        data[:lat] = store.lat
        data[:lng] = store.lng
      else
        data[:lat] = params[:lat] if params[:lat]
        data[:lng] = params[:lng] if params[:lng]
      end
      post = Post.new(data)
      if post.save
        # Tag
        if params[:tags] and !params[:tags].empty?
          Tag.generate(:tags => params[:tags], :user_id => current_user.id, :post_id => post.id)
        end
        # URL
        url_regexp = /https?:\/\/[\S]+/
        urls = post.post.scan(url_regexp)
        urls.each do |url|
          AttachedUrl.new(:user_id => current_user.id,
                  :store_id => params[:store_id],
                  :url => url).save
        end
        
        __success(post)
        return
      else
        __error(:code => 0, :description => "Failed to save")
        return
      end
    end
  end


  def delete
    if parameters_required :post_id
      post = Post.find(params[:post_id])
      if post.user_id == current_user.id
        if post.comment_count > 0
          post.post = "@DELETED@"
          if post.save
            __success("Deleted")
            return
          else
            __error(:code => 0, :description => "Failed to delete a post")
            return
          end
        else
          post.destroy
          __success()          
          return
        end
      else
        __error(:code => 0, :description => "Non authentication")
        return
      end
    end
  end


  def unlike
    if parameters_required :post_id
      like = Like.find(:first, :conditions => {:user_id => current_user.id, :object => "Post", :foreign_key => params[:post_id]})
      if like
        like.destroy
        __success("OK")
        return
      else
        __error(:code => 0 , :description => "No result for unliking")
        return
      end
    end
    
  end


  def like
    if parameters_required :post_id
      post = Post.find(:first, :conditions => {:id => params[:post_id]})
      if post.nil?
        __error(:code => 0, :description => "Invalid post id")
        return
      end
      
      like = Like.find(:first, :conditions => {:user_id => current_user.id, :object => "Post", :foreign_key => params[:post_id]})
      if like
        __error(:code => 0 , :description => "You already like this")
        return
      end
      
      like = Like.new(:user_id => current_user.id, :object => "Post", :foreign_key => params[:post_id])
      if like.save
        @mmm_user_id = post.user.id
        
        # Generate an alarm
        Alarm.new(:sent_user_id => current_user.id, :received_user_id => post.user_id, :alarm_type => "PostLike").save
        
        __success("Success to like a post")
        return
      else
        __error(:code => 0, :description => "Failed to like post")
        return
      end
    end
  end


  def list
    params[:id] = nil # remove id parameter for correct result
    conditions = ["activity_id IS NULL"]
    ret = __find(Post, conditions, nil)
    __respond_with ret, :include => [], :except => []
  end
  

  def store_list
    if parameters_required :store_id
      conditions = {:store_id => params[:store_id]}
      ret = __find(Post, conditions, nil)
      __respond_with ret, :include => [], :except => []
    end
  end


  def user_list
    if parameters_required :user_id
      params[:id] = nil
      conditions = {:user_id => params[:user_id]}
      ret = __find(Post, conditions, nil)
      __respond_with ret, :include => [], :except => []
    end
  end
  

  def my_list
    params[:id] = nil # remove id parameter for correct result
    conditions = {}
    conditions[:user_id] = current_user.id
    ret = __find(Post, conditions, nil)
    __respond_with ret, :include => [], :except => [] 
  end


  def nearby_list
    if parameters_required :lat_sw, :lat_ne, :lng_sw, :lng_ne
      params[:id] = nil
      conditions = {}
      conditions[:lat] = params[:lat_sw].to_f .. params[:lat_ne].to_f
      conditions[:lng] = params[:lng_sw].to_f .. params[:lng_ne].to_f
      ret = __find(Post, conditions, nil)
      __respond_with ret, :include => [], :except => []
    end
  end



  def region_list
    if parameters_required # to do
      params[:id] = nil
      ret = __find(Post, nil, nil)
      __respond_with ret, :include => [], :except => []
    end
  end

end
