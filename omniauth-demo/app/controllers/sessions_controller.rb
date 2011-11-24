require 'Users'

class SessionsController < ApplicationController
  def create
    ENV['sfdc_token'] = request.env['omniauth.auth']['credentials']['token']
    ENV['sfdc_instance_url'] = request.env['omniauth.auth']['instance_url']
    #render :text => request.env['omniauth.auth'].inspect
    
    redirect_to :controller => "users", :action => "index"
  #  render :text => Users.get_first_ten['records']
  end
  def fail
    render :text =>  request.env["omniauth.auth"].to_yaml
  end
  
  

end
