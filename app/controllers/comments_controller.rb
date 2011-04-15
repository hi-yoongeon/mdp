class CommentsController < ApplicationController
  before_filter :authentication_required, :only => [:new, :delete] 
  before_filter :http_post, :only => [:list]
  before_filter :http_get, :only => [:list]
  
  respond_to :xml, :json
  
  def new
    if parameters_required :post_id, :comment, :from_where
      comment = PostComment.new(:user_id => current_user.id, :comment => params[:comment], :post_id => params[:post_id], :from_where => params[:from_where])
      if comment.save
        __success(comment)
        return
      else
        __error(:code => 0, :description => "Failed to save the comment")
        return
      end
    end
  end

  
  def list
    if parameters_required :post_id
      params[:id] = nil
      conditions = {:post_id => params[:post_id]}
      ret = __find(PostComment, conditions)
      __respond_with(ret, :include => [:user])
    end
  end


  def delete
    if parameters_required :comment_id
      comment = PostComment.find(:first, :conditions => {:id => params[:comment_id]})
      if comment
        if comment.user_id == current_user.id
          comment.destroy
          __success("OK")
          return
        else
          __error(:code => 0, :description => "Non authentication for deleting")
          return
        end
      else
        __error(:code => 0, :description => "Comment id is invalid")
        return
      end
    end
  end
end
