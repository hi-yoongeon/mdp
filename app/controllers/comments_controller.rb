class CommentsController < ApplicationController
  before_filter :authentication_required, :only => [:new, :delete] 
  before_filter :http_post, :only => [:list]
  before_filter :http_get, :only => [:list]
  
  respond_to :xml, :json
  
  def new
    if parameters_required :post_id, :comment, :from_where
      post = Post.find(:first, :conditions => {:id => params[:post_id]})
      if post.nil?
        __error(:code => 0, :description => "Invalid post id")
        return
      end
      
      comment = PostComment.new(:user_id => current_user.id, :comment => params[:comment], :post_id => params[:post_id], :from_where => params[:from_where])
      if comment.save

        # Generate an alarm
        Alarm.new(:sent_user_id => current_user.id, :received_user_id => post.user_id, :alarm_type => "Comment").save
        
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
      ret = __find(PostComment, conditions, nil)
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
