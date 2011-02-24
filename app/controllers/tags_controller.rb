class TagsController < ApplicationController
  #before_filter :authentication_required
  respond_to :xml, :json

  
  def show
    if request.get? and parameters_required :tag_id
      params[:id] = params[:tag_id]
      ret = __find(Tag)
      respond_with ret
    end
  end
  
  def list
    if request.get?
      params[:id] = nil
      ret = __find(Tag)
      respond_with ret
    end
  end
  
  def store_tag_list
    if request.get? and parameters_required :store_id
      params[:id] = nil
      conditions = {:store_id => params[:store_id]}
      ret = __find(Tag,conditions)
      respond_with ret 
      conditions
    end
  end

  def user_tag_list
    if request.get? and parameters_required :user_id
      params[:id] = nil
      conditions = {:user_id => params[:user_id]}
      ret = __find(Tag,conditions)
      respond_with ret
    end
  end
  
  def post_tag_list
    if request.get? and parameters_required :post_id
      params[:id] = nil
      conditions = {:post_id => params[:post_id]}
      ret = __find(Tag,conditions)
      respond_with ret
    end
  end
  
  

end
