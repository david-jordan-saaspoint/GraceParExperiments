require 'net/https'

UN, PW = 'aviord4@utveckling', 'K5MeMmPP'

uri = Net::HTTP.new("https://obo.par.se", 443)

uri.use_ssl = true

resp = uri.get2("/itb/doc/S-W-4.xml?worksiteName=IKEA&worksiteGeneralCity=Stockholm", 'Authorization' => 'Basic' + ["#{UN}:#{PW}"].pack('m').strip)


