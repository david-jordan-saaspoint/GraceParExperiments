class ApplicationController < ActionController::Base
  protect_from_forgery
  #before_filter  ActiveSalesforce::SessionIDAuthenticationFilter
   before_filter :authentication_check
  @un, @pw = 'aviord4@utveckling', 'K5MeMmPP'
 
  def authentication_check
#    p session[:parAuthenticated]
 #   p "$$$$$ in authentication check of application controller $$$$$$$$$$$"
   session[:parAuthenticated] ||= self.class.basic_auth 'aviord4@utveckling', 'K5MeMmPP'
#   p session[:parAuthenticated]
  end
end
