
# httparty does not work - need oauth

require 'rubygems'
require 'httparty'
class Twitter
  include HTTParty
  base_uri 'twitter.com'

  def initialize(u, p)
    @auth = {:username => u, :password => p}
    
  end

  def post(text)
    options = { :query => {:status => text}, :basic_auth => @auth }
    self.class.post('/statuses/update.json', options)
  end
end

p Twitter.new('GraceRam2009', 'Saaspoint12').post("Tweeting using Httparty").inspect
#Twitter.new('dj_saaspoint', 'Spagetti1').post("Tweeting using Httparty")