# twittercall2.rb
require 'rubygems'
require 'rest_client'
require 'json'
 
class Twittercall2   
   
   # the URL for the Twitter Trends endpoint
    @url
 
    # constructor
    def initialize
            @url = 'http://api.twitter.com/1/trends.json'
         # @url = 'http://obo.par.se/itb/doc/S-W-4.xml'
    end
 
    # performs the GET request to get the trends from Twitter
    def getTrends
            response = RestClient.get(@url)
            return response.body
    end
 
    # returns the raw JSON of the response from Twitter
    def getJSON
            return getTrends()
    end
 
    # returns a human-friendly text version of the response from Twitter
    def getText
            hashOfResponse = JSON.parse(getJSON())
            textOfResponse = "Twitter Trends\n----------------\n\n"
            textOfResponse += "Results for: "+hashOfResponse['as_of']+"\n\n"
            # loop over the trends URLs returned and append them to the string to return
            hashOfResponse['trends'].each { |trend|
                    textOfResponse += "Trend: "+trend['name']+", URL: "+trend['url']+"\n"
            }
            return textOfResponse
    end
end

client = Twittercall2.new
puts client.getText()