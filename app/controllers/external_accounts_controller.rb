class ExternalAccountsController < ApplicationController
  before_filter :authentication_required
  before_filter :http_get, :only => [:show, :list, :callback]
  before_filter :http_post, :only => [:new, :delete]
  respond_to :xml, :json

  @@twitter_consumer_key = "SGjiU1MYRLEZ8bP0dcgnmA"
  @@twitter_consumer_secret = "uXmeeELnsAO5kh1wTNFgChHwuVDwoDrFfs4zy9mdNa0"
  @@facebook_app_id = "149836918417511"
  @@facebook_app_secret = "94a65ef2fbc57388195a8b32d043ebd9"

  
  def new
    if parameters_required :service
      case params[:service]
      when "twitter"
        __create_twitter
        return
      when "facebook"
        __create_facebook
        return
      end

      __error(:code => 0, :description => "no such service")
      return
    end
  end


  def show
    if parameters_required :external_account_id
      params[:id] = params[:external_account_id]
      extAccount = __find(UserExternalAccount)
      if extAccount.user_id == current_user.id
        __respond_with extAccount, :include => [], :except => []
      else
        __error(:code => 0, :description => "Non authentication")
      end
    end
  end

 
  def list
    params[:id] = nil
    conditions = {:user_id => current_user.id}
    extAccount = __find(UserExternalAccount, conditions)
  end


  def delete
    if parameters_required :external_account_id
      extAccount = UserExternalAccount.find(params[:external_account_id])
      if extAccount.user_id == current_user.id
        extAccount.destroy
        __success()
      else
        __error(:code => 0, :description => "Non authentication")
      end
    end
  end


  def callback
    if current_user and parameters_required :service
      case params[:service]
      when "twitter"
        __callback_twitter
      when "facebook"
        __callback_facebook
      end
    end
  end


  def twitter
    @twitter ||= OAuth::Consumer.new(@@twitter_consumer_key, @@twitter_consumer_secret, :site => "http://api.twitter.com", :request_endpoint => "http://api.twitter.com", :sign_in => true)
  end


  def twitter_pin
    if parameters_required :pin
      
    end
  end

  
  def facebook
    @facebook ||= FbGraph::Auth.new(@@facebook_app_id, @@facebook_app_secret)
  end



  
  def __create_twitter

    redirect_uri = "https://ygmaster.net/v2/external_accounts/callback?service=twitter"
    if params[:type] == 'mobile'
      redirect_uri << "&format=html&type=mobile"
    else 
      redirect_uri << "&format=#{params[:format]}"
    end
    
    request_token = twitter.get_request_token(:oauth_callback => redirect_uri)
    session["request_token"] = request_token.token
    session["request_secret"] = request_token.secret
    
    redirect_to request_token.authorize_url
  end


  def __callback_twitter
    request_token = OAuth::RequestToken.new(twitter, session['request_token'], session['request_secret'])
    access_token = request_token.get_access_token(:oauth_verfier => params[:oauth_verifier])
    oauth_data = ActiveSupport::JSON.encode({:access_token => access_token.token, :access_token_secret => access_token.secret, :screen_name => access_token.params[:screen_name]})

    twitterAccount = UserExternalAccount.find(:first, :conditions => ["user_id = ? AND service = ?", current_user.id, "twitter"])
    if twitterAccount.nil?
      twitterAccount = UserExternalAccount.new(:user_id => current_user.id, :service => "twitter", :data => oauth_data)
    else
      twitterAccount.data = oauth_data
    end
    
    if twitterAccount.save
      @code = 200
    else
      @code = 0
    end
    
    if params[:type] == 'mobile'
      render :template => 'external_accounts/success'
    else
      if @code == 200
        __success(twitterAccount)
        return
      else
        __error(:code => 0, :description => "Failed to connect twitter account")
        return
      end
    end
    

  end


  
  def __create_facebook
    
    redirect_uri = "https://ygmaster.net/v2/external_accounts/callback?service=facebook"
    if params[:type] == 'mobile'
      redirect_uri << "&format=html&type=mobile"
    else 
      redirect_uri << "&format=#{params[:format]}"
    end
    
    session[:redirect_uri] = redirect_uri
    
    redirect_to facebook.authorize_uri(redirect_uri, {:scope => [:publish_stream, :offline_access, :email]})
    
  end


  def __callback_facebook
    client = facebook.client
    client.redirect_uri = session[:redirect_uri]
    
    client.authorization_code = params[:code]
    access_token = client.access_token!
    
    
    facebookAccount = UserExternalAccount.find(:first, :conditions => ["user_id = ? AND service = ?", current_user.id, "facebook"])
    
    user = FbGraph::User.me(access_token).fetch
    
    oauth_data = ActiveSupport::JSON.encode({:access_token => access_token, :screen_name => user.email})
    if facebookAccount.nil?
      facebookAccount = UserExternalAccount.new(:user_id => current_user.id, :service => "facebook", :data => oauth_data)
    else
      facebookAccount.data = oauth_data
    end
    if facebookAccount.save
      @code = 200
    else
      @code = 0
    end
    
    
    if params[:type] == 'mobile'
      render :template => 'external_accounts/success'
    else
      if @code == 200
        __success(facebookAccount)
      else
        __error(:code => 0, :description => "Failed to connect facebook")
      end
    end
          
  end


  
  def tweet
    twitterAccount = UserExternalAccount.find(:first, :conditions => ["user_id = ? AND service = ?", current_user.id , "twitter"])
    puts twitterAccount.data
    
    oauth_data = ActiveSupport::JSON.decode(twitterAccount.data)
    puts @@twitter_consumer_key
    puts @@twitter_consumer_secret    
    puts oauth_data['access_token']
    puts oauth_data['access_token_secret']
    
    Twitter.configure do |config|
      config.consumer_key = @@twitter_consumer_key
      config.consumer_secret = @@twitter_consumer_secret
      config.oauth_token = oauth_data['access_token']
      config.oauth_token_secret = oauth_data['access_token_secret']
    end
    
    client = Twitter::Client.new

    ret = {:ret => client.update("Testing..")}
    __success(ret)
    return
  end


end
