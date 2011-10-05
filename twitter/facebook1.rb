require "rubygems"
require "sinatra"

require "net/http"
require "net/https"
require "cgi"

require "json"

enable :sessions

before do
  @client_id = "216883155038438"
  @client_secret = "f13d2e431f6b49665d0979f6749901fe"

  session[:oauth] ||= {}
end

get "/" do
  if session[:oauth][:access_token].nil?
    erb :start
  else
    http = Net::HTTP.new "graph.facebook.com", 443
    request = Net::HTTP::Get.new "/me?access_token=#{session[:oauth][:access_token]}"
    http.use_ssl = true
    response = http.request request
    @json = JSON.parse(response.body)

    erb :ready
  end
end

get "/request" do
  redirect "https://graph.facebook.com/oauth/authorize?client_id=#{@client_id}&redirect_uri=http://localhost:4567/callback"
end

get "/callback" do
  session[:oauth][:code] = params[:code]

  http = Net::HTTP.new "graph.facebook.com", 443
  request = Net::HTTP::Get.new "/oauth/access_token?client_id=#{@client_id}&redirect_uri=http://localhost:4567/callback&client_secret=#{@client_secret}&code=#{session[:oauth][:code]}"
  http.use_ssl = true
  response = http.request request

  session[:oauth][:access_token] = CGI.parse(response.body)["access_token"][0]
  redirect "/"
end

get "/logout" do
  session[:oauth] = {}
  redirect "/"
end

enable :inline_templates

