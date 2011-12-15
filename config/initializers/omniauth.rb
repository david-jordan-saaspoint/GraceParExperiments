require 'forcedotcom'

# Set the default hostname for omniauth to send callbacks to.
# seems to be a bug in omniauth that it drops the httpS
# this still exists in 0.2.0
OmniAuth.config.full_host = 'https://localhost:3000'

# heroku url - when deploying change this to whatever the heroku app remote access is
 #OmniAuth.config.full_host = 'https://api.heroku.com/myapps/falling-summer-2028'
 


module OmniAuth
  module Strategies
    #tell omniauth to load our strategy
    autoload :Forcedotcom, 'lib/forcedotcom'
  end
end


Rails.application.config.middleware.use OmniAuth::Builder do
  # authentication for test remote access
  provider :forcedotcom, '3MVG982oBBDdwyHic7R4GTiYnUirWOo5kTSN7FwNfwyXn8CDfrHiuopuS7FYSLvBvrZDS2OrqxMlriAcshQ.0', '2050336042674388207'
end