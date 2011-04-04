class CommentsController < ApplicationController
  before_filter :authentication_required, :only => [:new, :delete] 
  before_filter :http_post, :only => [:list]
  before_filter :http_get, :only => [:list]
  
  def new
    if parameters_required :post_id, :comment
      comment = Comment.new(:user_id => current_user.id, :comment => params[:comment], :post_id => params[:post_id])
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
      ret = __find(Comment, conditions)
      __respond_with(ret, :include => [:user])
    end
  end


  def delete
    if parameters_required :comment_id
      comment = Comment.find(:first, :conditions => {:id => params[:comment_id]})
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
