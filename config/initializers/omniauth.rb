require 'omniauth-salesforce'

# Set the default hostname for omniauth to send callbacks to.
# seems to be a bug in omniauth that it drops the httpS
# this still exists in 0.2.0

OmniAuth.config.full_host = 'https://127.0.0.1:3000'

# heroku url - when deploying change this to whatever the heroku app remote access is
 #OmniAuth.config.full_host = 'https://api.heroku.com/myapps/falling-summer-2028'
 


#module OmniAuth
#  module Strategies
    #tell omniauth to load our strategy
 ##   autoload :Forcedotcom, 'lib/forcedotcom'
#  end
#end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'eCaofvK84J9DfI9y57i12g', 'mwzS6SzXaIrdX2RdBjMQMK86wN9qnfO3IklBUrYLzw'
  provider :salesforce, '3MVG9rFJvQRVOvk5eTewVNSba15aB9I57XFdt19BhMdsGpzLC18tLc2kPpF8B_WmNEjjyYQcNdxOieiVuzcPP', '4545502207043831670'
end