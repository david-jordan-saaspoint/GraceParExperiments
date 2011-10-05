#dir = File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))
#require File.join(dir, 'httparty')
require 'pp'
require 'httparty'
#config = YAML::load(File.read(File.join(ENV['HOME'], '.twitter')))
#basic_auth 'grace_pauline@hotmail.com', 'Saaspoint12'

class Twitter
  include HTTParty
  
  base_uri 'twitter.com'
  
  def initialize(u, p)
    @auth = {:username => u, :password => p}
    basic_auth = @auth
  end
  
  # which can be :friends, :user or :public
  # options[:query] can be things like since, since_id, count, etc.
  def timeline(which=:user, options={})
    p @auth
    #options.merge!({:basic_auth => @auth})
    options =  { :basic_auth => @auth }
    self.class.get("/messages")
    #self.class.get("/statuses/#{which}_timeline.json", options )
  end
  
  def post(text)
    options = { :query => {:status => text}, :basic_auth => @auth }
    self.class.post('/statuses/update.json', options)
  end
end

#twitter = Twitter.new(config['grace_pauline@hotmail.com'], config['Saaspoint12'])
twitter = Twitter.new("GraceRam2009", "Saaspoint12")

twitter.post("twitter api through httparty")
#pp twitter.timeline
