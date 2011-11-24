class ApplicationController < ActionController::Base
  protect_from_forgery
  #before_filter  ActiveSalesforce::SessionIDAuthenticationFilter 
 
  p  @secret = Rails.application.config.secret_token
  
   before_filter :authentication_check
  # @un, @pw = 'aviord4@utveckling', 'K5MeMmPP'
   
  def authentication_check
#    p session[:parAuthenticated]
 #   p "$$$$$ in authentication check of application controller $$$$$$$$$$$"
   session[:parAuthenticated] ||= self.class.basic_auth @un, @pw
#   p session[:parAuthenticated]
   
  end
end
