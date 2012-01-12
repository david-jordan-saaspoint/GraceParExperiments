require 'databasedotcom'
require 'date'
require 'hpricot'
require 'omniauth'
require 'omniauth-salesforce'

class AuthenticationController < ApplicationController
  def index
    @authentications = current_user.authentications if current_user
  end
  def create1    # creates authnetication for twitter using omniauth with users loginname and password
    redirect_to :controller => "authentication", :action => "main_menu"
  # twitter_to_chatter
     # post_in_twitter
    # render :text => request.env["omniauth.auth"].to_yaml
  end
  
  def create
    sf_omniauth = request.env["omniauth.auth"]
    p sf_omniauth
    if  sf_omniauth["provider"] == "salesforce"
        p sf_omniauth["credentials"]["token"]
        p "sf uri", sf_omniauth["credentials"]["instance_url"]
        session[:sf_token] = sf_omniauth["credentials"]["token"]
        session[:sf_uri] = sf_omniauth["credentials"]["instance_url"]
        # redirect_to :controller => "authentication", :action => "main_menu"
        # redirect_to :controller => "authentication", :action => "create1"
        redirect_to '/auth/twitter'
     else
        twitter_omniauth = request.env["omniauth.auth"]
        session[:twitter_token] = twitter_omniauth["credentials"] ["token"]
        session[:twitter_secret] = twitter_omniauth["credentials"]["secret"]
        # developers consumer key and secret here
        session[:consumer_key] = "eCaofvK84J9DfI9y57i12g"
        session[:consumer_secret] = "mwzS6SzXaIrdX2RdBjMQMK86wN9qnfO3IklBUrYLzw"
        session[:last_id] = "157424867292102000"
        redirect_to :controller => "authentication", :action => "main_menu"
      end
  end
  
  def access_twitter
#      p "ot", session[:omniauth_token]
#      p "os" , session[:omniauth_secret]
#      p "at" , session[:accesstoken]
      twitter_user = OAuth::Consumer.new(session[:consumer_key], session[:consumer_secret] )
   #   twitter_user.update("Test Twit") 
      p "^^^^^^^^^^^^^^^^^^^^" , twitter_user
      token_hash = { :oauth_token => session[:twitter_token],
                 :oauth_token_secret => session[:twitter_secret]
               }
      access_token = OAuth::AccessToken.from_hash(twitter_user, token_hash )
    #  req = access_token.request(:get, "http://api.twitter.com/1/statuses/home_timeline.json")
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
    @messages = Array.new
    access_token = access_twitter
    p  last_id = session[:last_id]
  #  while true do
      url = "http://twitter.com/statuses/friends_timeline.xml?since_id=#{last_id}"
      # url = "http://api.twitter.com/statuses/user_timeline.xml"
      # url = "http://api.twitter.com/1/statuses/home_timeline.json"
    
      res = access_token.request(:get, url)
      response = Hpricot(res.body)
           
      if (response/'status').length > 0
        session[:last_id] = (response/'status id').first.inner_html
       
        (response/'status').each do |st|
          user = (st/'user name').inner_html
          text = (st/'text').inner_html
          twit_tim = (st/'created_at').first.inner_html
          message = "#{user} tweeted #{text} at #{twit_tim} "
          if text.include?("Chatter posting")
          else
            post_to_chatter(message)
            @messages.push(message)
          end
         end
       end
  #     sleep 60
 #    end 
       @messages
  end
  def login_chatter
    #  client new without any paramaeters
     client = Databasedotcom::Client.new :version =>23.0 # :client_id => "3MVG9rFJvQRVOvk5eTewVNSba15aB9I57XFdt19BhMdsGpzLC18tLc2kPpF8B_WmNEjjyYQcNdxOieiVuzcPP", :client_secret => "4545502207043831670", :version => "23.0"
    # better to replae this with oauth authentication and use omniauth token in place of username and password
     #client.authenticate request.env['omniauth.auth'] 
    # client.authenticate :username => "grace@developer.com", :password => "Saaspoint12jljdQI67xvlJ6suJPpfIdmdG"
  p   client.authenticate :token => session[:sf_token], :instance_url =>session[:sf_uri] 
     me = Databasedotcom::Chatter::UserProfileFeed.find(client)
     me
  end
   def access_chatter
     me = login_chatter
     me.each do |item|
       #  p item.likes
       
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
         if (Time.now - Time.parse(rec["createdDate"]))/3600 < 24 and !rec["body"]["text"].include?("tweeted")
          post_in_twitter(" '#{rec['body']['text']}' --Chatter posting by '#{rec['user']['name']}' on '#{rec['createdDate']}'. ")
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
  def post_to_chatter(message)
    me = login_chatter
    me.each do |item|
      item.comment(message)
    end
       
  end
  
  def fail
    render :text => request.env["omniauth.auth"].to_yaml
  end 
  
  def main_menu
    
  end
   def main_menu_choice
     choice = params[:integrate]
     if choice == "Chatter to Twitter"
       redirect_to :controller =>"authentication", :action => "chatter_to_twitter"
     elsif choice == "Twitter to Chatter"
      redirect_to :controller =>"authentication", :action =>  "twitter_to_chatter"
     else
       redirect_to :controller =>"authentication", :action => "exit"
     end
   end
    
end
