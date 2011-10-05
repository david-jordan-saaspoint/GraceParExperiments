require 'oauth'

def prepare_access_token(oauth_token, oauth_token_secret)
  # consumer key and secret while registering the app in dev.twitter.com
  consumer = OAuth::Consumer.new("Dg8BCI3ACmYU1gm66QtO5w", "7hkFjS0t7PI4yGW1UCkVTiGdwwD6Gqm4OR3izkVs0",
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
access_token = prepare_access_token("78850640-5tQwX4RUyce3XEZtYdrNWlcSwB0c8bfpy5Q7hbH5G", "fPYuRRxKH1wOAMnuLGBIRfdRy8BJgb4vGjHirwueE")
# use the access token as an agent to get the home timeline
response = access_token.request(:get, "http://api.twitter.com/1/statuses/user_timeline.json")
p response
p access_token.get('/account_verify_credentials.json')

p access_token.request(:post, "http://api.twitter.com/1/statuses/update.json",{:query => {"status" =>"tweeting from ruby app"}}).inspect
