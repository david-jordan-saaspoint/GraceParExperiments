
require 'rubygems'
require 'rest_client'
require 'net/https'
require 'net/http'
require 'json'


# need to remove all the hard coded codes and check the mesage.
@client_id = "216883155038438"
@client_secret = "f13d2e431f6b49665d0979f6749901fe"
@redirect_uri='https://fierce-dawn-1319.herokuapp.com/'
@scope='email,read_stream,offline_access,publish_stream'

server_code = RestClient.get('https://www.facebook.com/dialog/oauth?client_id=@client_id&redirect_uri=@redirect_uri&scope=@scope&grant_type=client_credentials')


p 'server_code', server_code

# need to cpature this is rails later on

@server_code = 'AQCiXPMj6BcO4PzWicl2nQM9z_bqpaJAQrfemec2IrFOKIt7tPOjKaY8h1vNAIIZZNwJ2bkJlvm5pnR7RIacchyjDDHRRki38JjXEdzggl6L0y63Kgo4aN8ScPoMgD4lBYGZMlO8vo6mGwIlMPpge3DC7QKWRRR-Ag-RIqX7NquOt0yI7lbm3WpFtq5pD-AUSz0#_=_'

@access_token = RestClient.get('https://graph.facebook.com/oauth/access_token?client_id=216883155038438&client_secret=f13d2e431f6b49665d0979f6749901fe&redirect_uri=https://fierce-dawn-1319.herokuapp.com/&code=AQCiXPMj6BcO4PzWicl2nQM9z_bqpaJAQrfemec2IrFOKIt7tPOjKaY8h1vNAIIZZNwJ2bkJlvm5pnR7RIacchyjDDHRRki38JjXEdzggl6L0y63Kgo4aN8ScPoMgD4lBYGZMlO8vo6mGwIlMPpge3DC7QKWRRR-Ag-RIqX7NquOt0yI7lbm3WpFtq5pD-AUSz0#_=_&grant_type=client_credentials')
p @access_token
#url = 'https://graph.facebook.com/access_token?client_id=#{@client_id}&client_secret=#{@client_secret}'

resp = RestClient.get('https://graph.facebook.com/me?'+@access_token)

p resp.body

p 'graceram likes:  ',  RestClient.get('https://graph.facebook.com/me/likes?'+@access_token)

# posting from backend 
RestClient.post('https://graph.facebook.com/me/feed?'+@access_token, :message=>'posting from backend')




