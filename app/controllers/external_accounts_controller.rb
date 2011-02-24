class ExternalAccountsController < ApplicationController
  before_filter :authentication_required
  #rescue_from Twitter::Unauthorized, :with => :force_sign_in
  respond_to :xml, :json

  @@twitter_consumer_key = "SGjiU1MYRLEZ8bP0dcgnmA"
  @@twitter_consumer_secret = "uXmeeELnsAO5kh1wTNFgChHwuVDwoDrFfs4zy9mdNa0"

  
  def new
    if request.get? and parameters_required :service
      case params[:service]
      when "twitter"
        ret = __create_twitter
      when "facebook"
        ret = __create_facebook
      end

    end
  end
  
  def show
    if reqeust.get? and parameters_required :external_account_id
      params[:id] = params[:external_account_id]
      extAccount = __find(UserExternalAccount)
      if extAccount.user_id == current_user.id
        respond_with extAccount
      else
        __error(:code => 0, :description => "Non authentication")
      end
    end
  end
  
  def list
    if request.get?
      params[:id] = nil
      conditions = {:user_id => current_user.id}
      extAccount = __find(UserExternalAccount, conditions)
    end
  end
  
  def delete
    if request.post? and parameters_required :external_account_id
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
    if request.get? and current_user and parameters_required :service
      case params[:service]
      when "twitter"
        __callback_twitter
      when "facebook"
        __callback_facebook
      end
    end
  end


  def twitter
    twitter ||= OAuth::Consumer.new(@@twitter_consumer_key, @@twitter_consumer_secret, :site => "http://api.twitter.com", :request_endpoint => "http://api.twitter.com", :sign_in => true)
  end
  
  def __create_twitter
    request_token = twitter.get_request_token(:oauth_callback => "http://matji.com/external_services/callback?service=twitter")
    session["request_token"] = request_token.token
    session["request_secret"] = request_token.secret
    
    redirect_to request_token.authorize_url
  end

  
  def __create_facebook
    
  end


  def __callback_twitter
    request_token = OAuth::RequestToken.new(twitter, session['request_token'], session['request_secret'])
    access_token = request_token.get_access_token(:oauth_verfier => params[:oauth_verifier])
    
    #reset_session
    access_token = access_token.token
    access_secret = access_token.secret

    oauth_data = ActiveSupport::JSON.encode({:access_token => access_token, :access_secret => access_secret})
    twitterAccount = UserExternalAccount.find(:first, :conditions => ["user_id = ? AND service = ?", current_user.id, "twitter"])
    
    if twitterAccount.nil?
      twitterAccount = UserExternalAccount.new(:user_id => current_user.id, :service => "twitter", :data => oauth_data)
    else
      twitterAccount.data = oauth_data
    end
    
    if extAccount.save
      __success(twitterAccount)
    else
      __error(:code => 0, :description => "Failed to connect twitter account")
    end
  end


  def __callback_facebook
  end

  
  def force_sign_in(exception)
    #reset_session
    flash[:error] = "It seems your credentials are not good anymore. Please sign in again"
  end


  
  def tweet
    twitterAccount = UserExternalAccount.find(:first, :conditions => ["user_id = ? AND service = ?", current_user.id, "twitter"])
    oauth_data = ActiveSupport::JSON.decode(twitterAccount.data)
    Twitter.configure do |config|
      config.consumer_key = @@twitter_consumer_key
      config.consumer_secret = @@twitter_consumer_secret
      config.oauth_token = oauth_data['access_token']
      config.oauth_token_secret = oauth_data['access_secret']
    end
    
    Twitter.update("Testing..")
    
  end
  
  
end
