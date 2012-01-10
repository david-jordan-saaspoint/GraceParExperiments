require 'databasedotcom'
require 'date'
class AuthenticationController < ApplicationController
  def index
    @authentications = current_user.authentications if current_user
  end
  def create
     omniauth = request.env["omniauth.auth"]
   # render :text => request.env["rack.auth"].to_yaml
      session[:omniauth_token] = omniauth["credentials"] ["token"]
      session[:omniauth_secret] = omniauth["credentials"]["secret"]
      session[:consumer_key] = "eCaofvK84J9DfI9y57i12g"
      session[:consumer_secret] = "mwzS6SzXaIrdX2RdBjMQMK86wN9qnfO3IklBUrYLzw"
      
    #  chatter_to_twitter
    #  redirect_to  :controller => "authentication", :action => "chatter_to_twitter"
    redirect_to  :controller => "authentication", :action => "twitter_to_chatter"
     # post_in_twitter
    # render :text => request.env["omniauth.auth"].to_yaml
  end
  
  def access_twitter
#      p "ot", session[:omniauth_token]
#      p "os" , session[:omniauth_secret]
#      p "at" , session[:accesstoken]
      twitter_user = OAuth::Consumer.new(session[:consumer_key], session[:consumer_secret] )
   #   twitter_user.update("Test Twit") 
      p "^^^^^^^^^^^^^^^^^^^^" , twitter_user
      token_hash = { :oauth_token => session[:omniauth_token],
                 :oauth_token_secret => session[:omniauth_secret]
               }
      access_token = OAuth::AccessToken.from_hash(twitter_user, token_hash )
      
      p "access_token" , access_token
      req = access_token.request(:get, "http://api.twitter.com/1/statuses/home_timeline.json")
 #  p   access_token.get('/account_verify_credentials.json') 
      access_token
  end
   #   session[:accesstoken] = omniauth["extra"]["access_token"]
   def post_in_twitter(message)
     access_token = access_twitter
 # change the message each time to avoid 403 error.  Twitter doesnt allow the same status message twice.
     access_token.post "https://api.twitter.com/1/statuses/update.json", :status => message  
  #    render :text => req.to_yaml
 #   end
   end
   def twitter_to_chatter
    access_token = access_twitter
    @resp = access_token.request(:get, "http://api.twitter.com/1/statuses/home_timeline.json").to_yaml
    
  end
   def access_chatter
     client = Databasedotcom::Client.new :client_id => "3MVG9rFJvQRVOvk5eTewVNSba15aB9I57XFdt19BhMdsGpzLC18tLc2kPpF8B_WmNEjjyYQcNdxOieiVuzcPP", :client_secret => "4545502207043831670", :version => "23.0"
     client.authenticate :username => "grace@developer.com", :password => "Saaspoint12jljdQI67xvlJ6suJPpfIdmdG"
     me = Databasedotcom::Chatter::UserProfileFeed.find(client)
     me.each do |item|
       #  p item.likes
       item.comments
       @chatter_feed = item.comments
       # item.comment("Sent from RoR on Monday")
     end     
     #   xx = me.post_status("Posting from RoR")
     #   p xx     
   end
   
   def chatter_to_twitter
       access_chatter
       chatter_name = Array.new
       chatter_text = Array.new
       chatter_date = Array.new
      
       @chatter_hash = Hash.new
       resp = @chatter_feed
       resp.each do |rec|
         
         
         p "$$$$  chatter record $$$$$$"
         
        # today_date = Time.now.strftime("%Y-%m-%d")
        # today_time = Time.now.strftime("%H:%M:%S")
        # p checkdate = rec["createdDate"].split("T")[0]
        # p checktime = rec["createdDate"].split("T")[1].split(".")[0]
         if (Time.now - Time.parse(rec["createdDate"]))/3600 < 100
          post_in_twitter("Chatter posting by '#{rec['user']['name']}' at '#{rec['createdDate']}'.  Text as follows: '#{rec['body']['text']}' ")
          chatter_text.push("#{rec['body']['text']}")
          chatter_name.push("#{rec['user']['name']}")
          chatter_date.push("#{rec['createdDate']}")
         end
     
         
      end  
      @chatter_hash[:nam] = chatter_name
      @chatter_hash[:tex] = chatter_text
      @chatter_hash[:dat] =  chatter_date
     # post_in_twitter(@chatter_hash)
      @chatter_hash   
  end
  
  
  def fail
    render :text =>  request.env["rack.auth"].to_yaml
  end 
    
end
