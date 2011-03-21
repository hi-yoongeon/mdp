# -*- coding: utf-8 -*-
require "matji_mileage_manager"

class ApplicationController < ActionController::Base
  # protect_from_forgery

  before_filter :mileage_setting
  after_filter :mileage_action

  def authentication_required
    if params[:access_token] and !params[:access_token].empty?
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
        msg = "The access token is invalid"
      end
    else
      if current_user
        return true
      else
        msg = "Access token parameter is required"
      end
    end
    
    __error(:code => 0, :description => msg)
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
    parameter = nil
    args.each do |arg| 
      parameter = arg.to_s
      if params[arg.to_sym].nil?
        invalid = true
        break
      end
    end
    
    if invalid
      msg = "Parameter '#{parameter}' is missing "
      __error(:code => 0, :description => msg)
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
    limit = 20
    
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
  

  def __error(arg = {})
    if arg[:code].nil?
      arg[:code] = 0
    end
    if arg[:template].nil?
      arg[:template] = 'errors/error'
    end

    ret = {:code => arg[:code], :description => arg[:description]}
    
    respond_with(ret) do |format|
      format.xml {render :xml => ret}
      format.json {render :json => ret}
      format.html do 
        @code = arg[:code]
        @msg = arg[:description]
        render :template => arg[:template]
      end
    end
  end


  def __success(object)
    ret = {:result => object,:code => 200}
    respond_with(ret) do |format|
      format.xml {render :xml => ret}
      format.json {render :json => ret}
      format.html {render :template => 'xmls/xml'}
    end
  end
  
  def __respond_with(resource, options={})
    if options.nil? 
      options = {}
    end
    
    options[:auth] = current_user

    if options[:include].nil?
      options[:include] = nil
    end
    if options[:except].nil?
      options[:except] = nil
    end
    if params[:include]
      options[:include] += params[:include].split(",").map(&:to_sym)
    end
    if params[:except]
      options[:except] += params[:except].split(",")
    end
      

    if params[:except]
       except_attrs = params[:except].split(",").map {|attr| attr.to_sym}
       options[:except] += except_attrs
    end	
    respond_to do |format|
      format.json do 
        options[:json] = resource
        render options
      end
      format.xml do 
        root = resource.is_a?(Array)? resource.first.class.to_s.downcase : resource.class.to_s.downcase
        render :template => "xmls/xml", :text => resource.as_json(options).to_xml(:root => root)
      end
      format.html { render }
    end
  end


  def mileage_setting
    @mmm = MatjiMileageManager.new(6)
  end

  def mileage_action
    rule = @mmm.act(params[:controller], params[:action])
    
    unless rule.nil?

      rule.each do |node|

        user_id = (node[:to] == "me") ? @mmm.from_user_id : @mmm_user_id
        @mmm.error if user_id.nil?

        MileageStackData.create(
                                :user_id => user_id, 
                                :flag => node[:flag], 
                                :point => node[:point],
                                :from_user_id => @mmm.from_user_id
                                )

        um = UserMileage.find_by_user_id(user_id)
        um[:total_point] += node[:point].to_i
        um.save

      end

    end
  end
    
end
