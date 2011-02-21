class UsersController < ApplicationController
  before_filter :login_required, :except => [:index, :login, :logout, :new, :create]
  before_filter :user_authentication_required, :only => [:show, :edit, :update, :destroy]
  respond_to :html, :json, :xml


  def index
    @user = current_user
    respond_with(@users = User.all)
  end

  
  def show
    @user = User.find(params[:id])
    respond_with(@user)
  end


  def new
    @user = User.new
  end


  def create
    @user = User.new(params[:user])
    if request.post?
      if @user.save
        session[:user] = User.authenticate(@user.userid, @user.password)
        flash[:message] = "Signup successful"
        redirect_to :action => "index"
      else
        flash[:warning] = "Signup unsuccessful"

      end
    end
  end


  def edit
    @user = User.find(params[:id])    
  end


  def update
    @user = User.find(params[:id])
  end

  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    
    redirect_to(:controller => "users", :action => "index")
  end


  def login
#     if current_user
#       if !params[:response_type].nil? && params[:response_type] == "code"
#         session[:code] = code = AccessGrant.random_string(10)
#         session[:return_to] = params[:redirect_uri] + "?code=" + code
#       end
#       redirect_to_stored
#       return
#     end

    if request.post?
      if session[:user] = User.authenticate(params[:user][:userid], params[:user][:password])
        flash[:message]  = "Login successful"
        if !params[:response_type].nil? && params[:response_type] == "code"
          session[:code] = code = AccessGrant.random_string(10)
          session[:return_to] = params[:redirect_uri] + "?code=" + code
        end
        redirect_to_stored
        return
      else
        flash[:warning] = "Login unsuccessful"
      end
    end
  end

  
  def logout
    session[:user] = nil
    flash[:message] = 'Logged out'
    redirect_to :action => 'index'
  end


  def forgot_password
    if request.post?
      u= User.find_by_email(params[:user][:email])
      if u and u.send_new_password
        flash[:message]  = "A new password has been sent by email."
        redirect_to :action=>'login'
      else
        flash[:warning]  = "Couldn't send password"
      end
    end
  end


  def change_password
    @user=session[:user]
    if request.post?
      @user.update_attributes(:password=>params[:user][:password], :password_confirmation => params[:user][:password_confirmation])
      if @user.save
        flash[:message]="Password Changed"
      end
    end
  end
  
  

  

  protected
  def user_authentication_required
    if current_user
      if params[:id].to_i == current_user.id
        return true
      end
    end
    
    msg = 'Non authentication'
    __error(:code => 0, :description => msg, :template => 'errors/error')
    return false
  end

  



  
end
