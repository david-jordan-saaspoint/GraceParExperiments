require 'net/https'
#http = Net::HTTP.new('api.del.icio.us', 443)
http = Net::HTTP.new("https://www.salesforce.com", 443)
http.use_ssl = true
http.start do |http|
   req = Net::HTTP::Get.new('/001/o')

   # we make an HTTP basic auth by passing the
   # username and password
   #req.basic_auth 'aviord4@utveckling', 'K5MeMmPP'
  req.basic_auth 'grace@par-dev.com', 'Saaspoint12VmnWWoESfynbRW4RqG754SXD'
   resp, data = http.request(req)
end

