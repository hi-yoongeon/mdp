class TagsController < ApplicationController
  #before_filter :authentication_required
  before_filter :http_get, :only => [:show, :list, :store_tag_list, :user_tag_list, :post_tag_list]
  before_filter :http_post, :only => [:new]
  respond_to :xml, :json

  
  def show
    if parameters_required :tag_id
      params[:id] = params[:tag_id]
      ret = __find(Tag)
      respond_with ret, :include => [], :except => []
    end
  end
  
  def list
    params[:id] = nil
    ret = __find(Tag)
    respond_with ret, :include => [], :except => []
  end
  

  def store_tag_list
    if parameters_required :store_id
      params[:id] = nil
      conditions = {:store_id => params[:store_id]}
      storeTags = __find(StoreTag,conditions)
      tags = storeTags.map { |storeTag| storeTag.tag }
      respond_with tags, :include => [], :except => []
    end
  end


  def user_tag_list
    if parameters_required :user_id
      params[:id] = nil
      conditions = {:user_id => params[:user_id]}
      userTags = __find(UserTag,conditions)
      tags = userTags.map { |userTag| userTag.tag }
      respond_with tags, :include => [], :except => []
    end
  end
  
  def post_tag_list
    if parameters_required :post_id
      params[:id] = nil
      conditions = {:post_id => params[:post_id]}
      postTags = __find(PostTag,conditions)
      tags = postTags.map { |postTag| postTag.tag }
      respond_with tags, :include => [], :except => []
    end
  end
  

end
