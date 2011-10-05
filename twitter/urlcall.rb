require 'net/http'

#url = 'http://search.yahooapis.com/WebSearchService/V1/webSearch?appid=YahooDemo&query=madonna&results=1'
url = "http://developer.yahoo.com/ruby/ruby-rest.html"
#url = 'https://obo.par.se'
resp = Net::HTTP.get_response(URI.parse(url)) # get_response takes an URI object
begin
  data = resp.body
  puts data
rescue
   print "Connection error."
end
