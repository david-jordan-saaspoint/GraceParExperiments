

  class SessionsController < ApplicationController
    def create
      reset_session 
      ENV['sfdc_token'] = request.env['omniauth.auth']['credentials']['token']
      ENV['sfdc_instance_url'] = request.env['omniauth.auth']['instance_url']
   #   authentication = Authentication.find_or_create_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
      p " logged"
      p request.env['omniauth.auth'].inspect
     session[:token] = request.env['omniauth.auth']["credentials"]["token"]
     session[:uri] = request.env['omniauth.auth']["instance_url"]
      #render :text => Accounts.get_first_hundred.inspect
      #render :text => Contacts.get_contacts.inspect
      flash[:notice] = "Authentication successful."
      redirect_to :controller => 'user', :action => 'index'
   end
    def fail
      render :text =>  request.env["omniauth.auth"].to_yaml
    end
    def destroy  
    reset_session  
    flash[:notice] = "Logged out." 
  #  redirect_to posts_url 
  end
  end

