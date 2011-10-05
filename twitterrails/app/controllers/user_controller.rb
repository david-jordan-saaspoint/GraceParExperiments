require 'rubygems'




class UserController < ApplicationController
  
  def self.consumer 
    OAuth::Consumer.new("Dg8BCI3ACmYU1gm66QtO5w", "7hkFjS0t7PI4yGW1UCkVTiGdwwD6Gqm4OR3izkVs0", {site => "http://twitter.com"})
  end
  
  def create
    @request_token = UserController.consumer.get_request_token
    session[:request_token] = @request_token.token
    session[:request_token_secret] = @request_token.secret
    
    redirect_to @request_token.authorize_url
    return
  end

  def callback
#  http://127.0.0.1:3000/auth/twitter/callback
  @request_token = OAuth::RequestToken.new(UserController.consumer, session[:request_token], session[:request_token_secret])
  
  @access_token = @request_token.get_access_token
  @response = UserController.consumer.request(:get, '/account/verify_credentials.json', @access_token, {:scheme => :query_string})
  
  case @response
  when Net::HTTPSuccess
    user_info = JSON.parse(@response.body)
    unless user_info['screen_name']
      flash[:notice] = "Authentication failed"
      redirect_to :action => :index
      return
    end
   @user = User.new({:screen_name => user_info['screen_name'], :token => @access_token.token, :secret => @access_token.secret})
   @user.save!
   
   redirect_to(@user)
   else
     RAILS_DEFAULT_LOGGER.error "Failed to get user info through OAUTH"
     
     flash[:notice] = 'Authentication failed'
     
     redirect_to :action =>index
     return
   end
  end

  def show
    
    @user = User.find(params[:id])
# 
   @access_token = OAuth::AccessToken.new(UsersController.consumer, @user.token, @user.secret)
   RAILS_DEFAULT_LOGGER.error "Making OAuth request for #{@user.inspect} with #{@access_token.inspect}"
   @response = UsersController.consumer.request(:get, '/favorites.json', @access_token, { :scheme => :query_string })
   case @response
    when Net::HTTPSuccess
    @favorites = JSON.parse(@response.body)
    respond_to do |format|
    format.html # show.html.erb
    end
    else
      RAILS_DEFAULT_LOGGER.error "Failed to get favorites via OAuth for #{@user}"
    # The user might have rejected this application. Or there was some other error during the request.
    flash[:notice] = "Authentication failed"
    redirect_to :action => :index
    return
   end
 end
end
