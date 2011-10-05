#require 'twitter_oauth'
#client = TwitterOAuth::Client.new  

#puts client.show('twitter')


require 'rubygems'
require "twitter"

p Twitter.user_timeline("GraceRam2009").first.text

search = Twitter::Search.new
search.containing("free offer").result_type("recent").per_page(3).each do |e| 
  p "#{e.text}"
end

Twitter.configure do |config|
  config.consumer_key = "Dg8BCI3ACmYU1gm66QtO5w"
  config.consumer_secret = "7hkFjS0t7PI4yGW1UCkVTiGdwwD6Gqm4OR3izkVs0"
  config.oauth_token = "78850640-6oQpsT3aMRGzwTGoZZeult24vD2SPAOQXMlSKWpYm"
  config.oauth_token_secret= "lSzfqmcqd4wvH3p0oKi8geaXzVC1VcSecc0RaELnolo"
end

client = Twitter::Client.new
#client.update("This update is via Twitter oauth")

p client.home_timeline.first.text

#p client.friends.sort{|a,b| a.followers_count <=> b.follwers_count}. reverese.first.name
#p client.followers.sort{|a,b| a.followers_count <=> b.follwers_count}. reverese.first.name

p client.rate_limit_status.remaining_hits.to_s + "Twitter API requests remaining this hour"



