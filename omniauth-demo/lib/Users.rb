require 'rubygems'
require 'httparty'

class Users
  include HTTParty
  #doesn't seem to pick up env variable correctly if I set it here
  #headers 'Authorization' => "OAuth #{ENV['sfdc_token']}"
  format :json
  #debug_output $stderr

  def self.set_headers
    headers 'Authorization' => "OAuth #{ENV['sfdc_token']}"
  end

  def self.root_url
    @root_url = ENV['sfdc_instance_url']+"/services/data/v"+ENV['sfdc_api_version']
  end

  def self.get_first_ten
    Users.set_headers
    get(Users.root_url+"/query/?q=#{CGI::escape('SELECT Id, firstName, Lastname, Name, Email,IsActive, Title, Department, Username, PAR121__PAR_Username__c, ProfileId, UserRoleId, PAR121__PAR_Password__c  from User LIMIT 100')}")
  end
  
  def self.search(keyword)
    Users.set_headers
    soql = "SELECT Id, Name, Email,IsActive, Title, Department, Username, PAR121__PAR_Username__c, ProfileId, UserRoleId, PAR121__PAR_Password__c from User Where FirstName = \'#{keyword}\' "
    get(Users.root_url+"/query/?q=#{CGI::escape(soql)}")
  end
  
  def self.create()
    Users.set_headers
    headers 'Content-Type' => "applciation/json"
    
    options = {
      :body => {
        :Name => "Testing"

      }.to_json
    }
    response = post(Users.root_url+"/sobjects/User/", options)
  end
  
  def self.save(params)
    Users.set_headers
    headers 'Content-Type' => "application/json"
    
    options = {
      :body => {
        :email => params[:email],
        :active =>params[:active]
        
      }.to_json
    }
    p options
    response = post(Users.root_url+"/sobjects/User/#{params[:id]}?_HttpMethod=PATCH", options)
  end
 
 def self.retrieve(id)
   Users.set_headers
   get(Users.root_url+"/sobjects/User/#{id}?fields=Name,Email,IsActive,ProfileId,UserRoleId")
 end
 
 
end