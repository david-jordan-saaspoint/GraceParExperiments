require 'oauth'
require 'twitter'

def prepare_access_token(oauth_token, oauth_token_secret)
  # consumer key and secret while registering the app in dev.twitter.com
  consumer = OAuth::Consumer.new("aSlCzmFgfK0X0n0dp5oWQ", "WgQmTJNFNh1MZ5InwF28UkhVVfFrD288GSEOdyk4SY",
    { :site => "http://api.twitter.com",
      :scheme => :header
    })
  # now create the access token object from passed values
  token_hash = { :oauth_token => oauth_token,
                 :oauth_token_secret => oauth_token_secret
               }
  access_token = OAuth::AccessToken.from_hash(consumer, token_hash )
  return access_token
end
 
# Exchange our oauth_token and oauth_token secret for the AccessToken instance.

# access token and access secret while registering the app in dev.twitter.com
access_token = prepare_access_token("78850640-DdoCHVfOLWD0M2OEEAuoshh1pLuKWfDIz9GUiirmQ", "A9Cc640zOMxxAoLxQKuvprtKtODch2g44rxckqYSMI")

p access_token
# use the access token as an agent to get the home timeline
response = access_token.request(:get, "http://api.twitter.com/1/statuses/user_timeline.json")
p response
p access_token.get('/account_verify_credentials.json')
p access_token.request(:post, "http://api.twitter.com/1/statuses/update.json",{:query => {"status" =>"True contentment is found, not in having everything you want, but in not wanting to have everything"}})