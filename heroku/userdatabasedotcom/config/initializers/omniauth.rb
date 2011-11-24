require 'forcedotcom'

# Set the default hostname for omniauth to send callbacks to.
# seems to be a bug in omniauth that it drops the httpS
# this still exists in 0.2.0
#OmniAuth.config.full_host = 'https://localhost:3000'

# heroku url - when deploying change this to whatever the heroku app remote access is
 OmniAuth.config.full_host = 'https://api.heroku.com/myapps/strong-frost-4250'
 


module OmniAuth
  module Strategies
    #tell omniauth to load our strategy
    autoload :Forcedotcom, 'lib/forcedotcom'
  end
end


Rails.application.config.middleware.use OmniAuth::Builder do
 # provider :forcedotcom, '3MVG9QDx8IX8nP5SZh4eVqHyA0V.FsDc_RWvWL.6DUJVUrLLumMSOecJZ_1Io5y8Hs86kFXHYi9goW4Hycmof', '892547349198510318'
  provider :forcedotcom, '3MVG9QDx8IX8nP5SZh4eVqHyA0Qc5YFw1cbynTj7h3FkQ2ZryBxB6I2q2995_4yooG6Azwi30rKcvyz7jmSAN', '3957039819365459519', {:client_options => {:ssl => {:ca_path => "/lib/certs"}}}
end