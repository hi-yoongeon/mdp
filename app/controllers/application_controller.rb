class ApplicationController < ActionController::Base
  protect_from_forgery
  

  def authentication_required
    if params[:access_token]
      # Validate access_token whether exists and not expired
      if AccessGrant.access_token_exists?(params[:access_token])
#         if AccessGrant.access_token_expired?(params[:access_token])
#           return true
#         else
#           @msg = "Access token is expired"
#         end
        session[:user] = AccessGrant.user_for_access_token(params[:access_token])
        return true
      else
        @msg = "The access token is invalid"
      end
    else
      @msg = "Access token parameter is required"
    end
    
    @code = 0
    render :template => 'errors/error'
    return false
  end



  def login_required
    if session[:user]
      return true
    end
    flash[:warning]='Please login to continue'
    session[:return_to]=request.request_uri
    redirect_to '/login'
    return false
  end



  def parameters_required(*args)
    invalid = false
    args.each do |arg| 
      if arg.class == String
        if params[arg.to_sym].nil?
          invalid = true
          break
        end
      elsif arg.class == Symbol
        if params[arg].nil?
          invalid = true
          break
        end
      else
        invalid = true
        break
      end
    end
    
    if invalid
      return false
    end
    
    return true
  end


  def current_user
    session[:user]
  end


  def redirect_to_stored
    if return_to = session[:return_to]
      session[:return_to]=nil
      redirect_to(return_to)
    else
      redirect_to :controller=>'users', :action=>'index'
    end
  end


  

  def __find(model, conditions = {})
    offset = 0
    limit = 5
    
    if params[:id]
      conditions[:id] = params[:id].split(",")
    end
    if params[:limit]
      limit = params[:limit].to_i
    end
    if params[:page]
      offset = (params[:page].to_i - 1) * limit
    end


    ret = model.find(:all, :conditions => conditions, :limit => limit, :offset => offset)
    return ret
  end
  
end
