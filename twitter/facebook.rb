
require 'rubygems'
require 'rest_client'
 
url = 'https://graph.facebook.com/danielramamoorthy?metadata=1n'
#url1 = 'https://graph.facebook.com/danielramamoorthy/picture'
url1 = 'https://graph.facebook.com/graceram/picture'

response = RestClient.get(url)
puts response.body
response = RestClient.get(url1)
puts response.body

url2 = 'https://graph.facebook.com/danielramamoorthy'
response = RestClient.get(url2)
puts response.body

url3 = 'https://graph.facebook.com/search?until=yesterday&q=orange'
response = RestClient.get(url3)
puts response.body

url4 = 'https://graph.facebook.com/search?since=yesterday&q=orange'
response = RestClient.get(url4)
puts response.body

#ç/danielramamoorthy/picture
#https://graph.facebook.com/danielramamoorthy/likes?limit=3&access_token=
# checkins. likes and frineds need access token 

#https://graph.facebook.com/dialog/oauth?...

#AQBE62uSrKAyOCK8JwPnQkDrFTLUE_ly9GS24JIhzfs_agqWiWbrLDWnU-mz4wBN-4SdEN9w5o2LLqaOpxnUsh4KJmfQ_oJtTbjuFfH_kp7C1ee3X9qMtNy9WCGq1Sh6sOHw2ShYDB-k_0CgGzsb0AqbQeiZTgrP-PmrSE8i7oMkGw0TXe0AZFGI7nPq4wG5McpU0oStY3VVcmDbGu3Gio8v#_=_
# to get access token - use appid and redirect uri to get a server code
#then use the appid, appsecret and code in graph.facebook.com to get access code.
#AAADFQQtp8OYBANlXTRHQkAaaBQY60ZAyNtPhDkZCqlqyzZCzwKrJEsTz7wzYzZCZAzwi2bJ4ZBBrPBjOguIF1a7X2BZCbcJkOZADIedC3KsF3OMXFpqNfRGd