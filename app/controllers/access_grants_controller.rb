class AccessGrantsController < ApplicationController
#  before_filter :login_required, :only => [:index, :show, :new, :create, :update, :edit, :destroy]
  before_filter :parameter_valid?, :authorization_valid? , :only => :authorize
    
  respond_to :html, :xml, :json
  

  def token_generator_for_migrate
    if parameters_required :user_id
      @user = User.find(params[:user_id])
      @client = Client.find(1)
      render :text => access_grant_generator.access_token
    end
  end


  def index
    @access_grants = AccessGrant.find_all_by_user_id(current_user.id)
    @access_grants = [] if @access_grants.nil?
    
    __respond_with(@access_grants)
  end

  def show
    
  end

  def new
    
  end
  
  def create
    
  end
  
  def update
    
  end
  
  def edit
    
  end
  
  def destroy
    grant = AccessGrant.find(params[:id])
    if grant.user_id = current_user.id
      grant.destroy
    end
    redirect_to access_grants_path
  end
    

  def callback
    res = {}
    res[:access_token] = params[:access_token]
    res[:user] = AccessGrant.find_by_access_token(params[:access_token]).user
    render :json => res
  end

  
  def authorize
    response_type = params[:response_type]
    grant_type = params[:grant_type]

    if response_type == "code"
#       if current_user
#         redirect_to "/login?response_type=code&redirect_uri=" + params[:redirect_uri]
#         return 
#       else
      @redirect_uri = params[:redirect_uri]
      render
      return
#      end
      # render login view for application
    elsif response_type == "password" || grant_type == "authorization_code"
      redirect_to (params[:redirect_uri] +"?access_token=#{access_token}&token_type=bearer")
      return
    end
  end


  protected
  def parameter_valid?
    invalid = false
    if params[:response_type]
      if params[:client_id].nil?
        invalid = true
        @msg = "client_id is missing"
      elsif params[:redirect_uri].nil?
        invalid = true
        @msg = "redirect_uri is missing"          
      end
      if params[:response_type] == "code"
      elsif params[:response_type] == "password"
        if params[:client_secret].nil?
          invalid = true
          @msg = "client_secret is missing"
        elsif params[:userid].nil?
          invalid = true
          @msg = "userid is missing"
        elsif params[:password].nil?
          invalid = true
          @msg = "password is missing"
        end
      else
        invalid = true
        @msg = "invalid response_type"
      end
      
    elsif params[:grant_type]
      if params[:grant_type] == "authorization_code"
        if params[:client_id].nil?
        elsif params[:client_secret].nil?
          invalid = true
          @msg = "client_secret is missing"            
        elsif params[:code].nil?
          invalid = true
          @msg = "code is missing"
        elsif params[:redirect_uri].nil?
          invalid = true
          @msg = "redirect_uri is missing"
        end
      else
        invalid = true
        @msg = "invalid grant_type"
      end
      
    else
      invalid = true
      @msg = "Required parameters are missing(response_type / grant_type)"
    end
    
    if invalid
      @code = 0
      render :template => 'errors/error'
      return
    end
  end


  def authorization_valid?
    response_type = params[:response_type]
    grant_type = params[:grant_type]
    invalid = false
    if response_type == "code"
      #====================================
      # response_type "code" validation
      #====================================
      @client = Client.find_by_client_id(params[:client_id])
      if @client.nil?
        invalid = true
        @msg = "client_id is incorrect"
      end

    elsif response_type == "password"
      #====================================
      # response_type "password" validation
      #====================================
      @client = Client.find(:first, :conditions => ["client_id = ? AND client_secret = ?", params[:client_id],params[:client_secret]])
      if @client.nil?
        invalid = true
        @msg = "client_id or client_secret is incorrect"
      end
      
      @user = User.authenticate(params[:userid], params[:password])
      if @user.nil?
        invalid = true
        @msg = "userid or password is incorrect"
      end


    elsif grant_type == "authorization_code"
      #============================================
      # grant_type "authorization_code" validation
      #============================================
      @client = Client.find(:first, :conditions => ["client_id = ? AND client_secret = ?", params[:client_id],params[:client_secret]])
      if @client.nil?
        invalid = true
        @msg = "client_id or client_secret is incorrect"
      end
      
      if params[:code] != session[:code]
        invalid = true
        @msg = "code is incorrect"
      else
        @user = current_user
      end
      
    end


    if invalid
      @code = 0
      render :template => 'errors/error'
      return
    end
    
  end
    
  
  private
  def access_grant_generator
    hash = @user.hashed_password || @user.old_hashed_password
    text = hash + @client.client_secret + DateTime.now.to_f.to_s
    token = AccessGrant.generate_token(text)
    
    # access token valids for a week
    expires_at = DateTime.now + 7
    access_grant = AccessGrant.new(:access_token => token, :access_token_expires_at => expires_at, :user_id => @user.id, :client_id => @client.id)
    if access_grant.save
      return access_grant
    end
    nil
  end
  
  
  
  def access_token
    access_grant = AccessGrant.find(:first, :select => "access_token", :conditions => ["user_id = ? AND client_id = ?", @user.id, @client.id])

    if access_grant
      return access_grant.access_token
    else
      return access_grant_generator.access_token
    end
  end



  



end
