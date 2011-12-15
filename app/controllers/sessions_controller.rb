class SessionsController < ApplicationController
  def create
    ENV['sfdc_token'] = request.env['omniauth.auth']['credentials']['token']
    ENV['sfdc_instance_url'] = request.env['omniauth.auth']['instance_url']
    
 p  "token",  session[:token] = request.env['omniauth.auth']["credentials"]["token"]
 p   session[:uri] = request.env['omniauth.auth']["instance_url"]
      
 p   session[:auth] = request.env['omniauth.auth']
      
  #  render :text => request.env['omniauth.auth'].inspect
    redirect_to '/'
    
  end
  
  def fail
    render :text =>  request.env["omniauth.auth"].to_yaml
  end

end
