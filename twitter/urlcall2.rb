require 'net/https'


http.use_ssl = true
UN = "demo@par"
PW = "AJAX"

http.start do |http|
   req = Net::HTTP::Get.new('/itb/doc/S-W-4.xml?worksiteName=IKEA&worksiteGeneralCity=Stockholm')
   # 'Authorization' => 'Basic' + ["#{UN}:#{PW}"].pack('m').strt')

   # we make an HTTP basic auth by passing the
   # username and password
  req.basic_auth '#[UN]', '#[PW]'

   resp, data = http.request(req)
end

