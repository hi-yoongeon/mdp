class ClientsController < ApplicationController
  before_filter :authentication_required , :only => :temp
  before_filter :login_required , :except => :temp
  before_filter :client_authentication_required , :only => [:show, :edit, :update, :destroy]
  respond_to :html, :xml, :json
  
  def index
    user = current_user
    @clients = Client.find_all_by_user_id(user.id)
    @clients = [] if @clients.nil?
  end

  def show
    @client = Client.find(params[:id])
    respond_with(@client)
  end

  def new
    @client = Client.new
    
  end

  def create
    plaintext = params[:application_name] + DateTime.now.to_f.to_s + params[:redirect_uri]
    token = AccessGrant.generate_token(plaintext)
    client_id = token[0,10]
    client_secret = token[10, 40]
    @client = Client.new(:application_name => params[:application_name], :redirect_uri => params[:redirect_uri], :client_id => client_id , :client_secret => client_secret, :user_id => current_user.id)
    

    if @client.save
      respond_with(@client)
    end
  end


  def edit
    @client = Client.find(params[:id])
  end


  def update
    @client = Client.find(params[:id])
    
    if @client.update_attributes(:redirect_uri => params[:redirect_uri])
      redirect_to (@client)
    else
      render :action => "edit"
    end
  end


  def destroy
    client = Client.find(params[:id])
    client.destroy
    redirect_to( :action => "index" )
  end


  def temp
    user = AccessGrant.user_for_access_token(params[:access_token])
    render :json => user
  end


  protected
  def client_authentication_required
    if login_required
      client = Client.find(:first, :select => "user_id", :conditions => ["id = ?", params[:id]])
      if client.user_id == current_user.id
        return true
      end
    end
    @code = 0
    @msg = 'Non authentication'
    render :template => 'errors/error'
    return false
  end  


  
end
