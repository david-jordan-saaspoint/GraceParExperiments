require 'rubygems'
require 'rest_client'
require 'net/https'
require 'net/http'
require 'json'

class FBAccount
  
  @client_id = "216883155038438"
  @client_secret = "f13d2e431f6b49665d0979f6749901fe"

  def authorize_url(callback_url = '')
    if self.oauth_authorize_url.blank?
      self.oauth_authorize_url = "https://graph.facebook.com/oauth/authorize?client_id=#{@client_id}&redirect_uri=#{callback_url}&scope=offline_access,publish_stream"
      self.save!
    end
   # self.oauth_authorize_url
  end
  
  def validate_oauth_token(oauth_verifier, callback_url = '')
    response = RestClient.get 'https://graph.facebook.com/oauth/access_token', :params => {
                   :client_id => @client_id,
                   :redirect_uri => callback_url.html_safe,
                   :client_secret => @client_secret,
                   :code => oauth_verifier.html_safe
                }
    pair = response.body.split("&")[0].split("=")
    if (pair[0] == "access_token")
      self.access_token = pair[1]
      response = RestClient.get 'https://graph.facebook.com/me', :params => { :access_token => self.access_token }
      self.stream_url = JSON.parse(response.body)["link"]
      self.active = true
    else 
      self.errors.add(:oauth_verifier, "Invalid token, unable to connect to facebook: #{pair[1]}")
      self.active = false
    end
    self.save!
  end
  
  def post(message)
    RestClient.post 'https://graph.facebook.com/me/feed', { :access_token => self.access_token, :message => message }
  end
end

fbclient = FBAccount.new
fbclient.authorize_url('https://fierce-dawn-1319.herokuapp.com/')
