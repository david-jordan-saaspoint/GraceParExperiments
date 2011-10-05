require 'net/http'

url = URI.parse('http://www.ruby-doc.org/stdlib/libdoc/net/http/rdoc/index.html')
appid = 'YahooDemo'

context = 'Italian sculptors and painters of the renaissance favored
the Virgin Mary for inspiration'
query = 'madonna'

post_args = {
   'appid' => appid,
   'context' => context,
   'query' => query
}

resp, data = Net::HTTP.post_form(url, post_args)