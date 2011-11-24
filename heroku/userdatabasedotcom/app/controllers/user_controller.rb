 require 'rubygems'
  require 'httparty'
  require 'nokogiri'
  require 'open-uri'
  require 'databasedotcom'
  require 'uri'
  require 'pg'
  require 'openssl'
class UserController < ApplicationController
  include HTTParty
  include Nokogiri
  include Databasedotcom
 
  def set_headers
 #   headers 'Authorization' => "OAuth #{ENV['sfdc_token']}"
      ENV['sfdc_token'] = request.env['omniauth.auth']['credentials']['token']
      ENV['sfdc_instance_url'] = request.env['omniauth.auth']['instance_url']
    session[:token] = ENV['sfdc_token']
    session[:uri] =  ENV['sfdc_instance_url']  
  end

  
  def authorize
 #   set_headers
    p " output"
#p     ENV['sfdc_token'] = request.env['omniauth.auth']['credentials']['token']
#p      ENV['sfdc_instance_url'] = request.env['omniauth.auth']['instance_url']
    p session[:token] = "00DU0000000ITUe!ASAAQEUhXsO_Yo.vM.3ESPAKBvyUTDeZfkEK0Ji0Nh2HPCeGhVT8wHMbGw2rlxQEZ.qh1XQf_Gz5ik9kaDbE3Oq0cdnwQvCh"
    p session[:uri] ="https://na12.salesforce.com"
#    p request.env['omniauth.auth'].inspect
p    client = Databasedotcom:: Client.new 
    client.authenticate(:options => nil, :token => session[:token], :instance_url => session[:uri])
#   p client.authenticate request.env['omniauth.auth']  
    users = client.materialize("User")
    roles = client.materialize("UserRole")
    profiles = client.materialize("Profile")
    session[:client] = client
  end
  def index
    # this can be dropped after all the debugging is done as 
    #this is an unwanted query from sfdc
    
    search
    userId= Array.new
    @users = User.all
    @users.each do |user| 
        user = user.Id[0..-4]
        userId.push(user)
      end
     
     @users
  
#  @result = Pardb.find_by_sfdc_id(userId, :select => "par_un, par_pw")
  end
  
  def search
    authorize
    @rolenames = Hash.new
    @profilenames = Hash.new
    @rolenames[0] = 'All'
    @profilenames[0] = 'All'
    @roles = UserRole.query("Portaltype='None'")
    @roles.each { |role|  @rolenames[role.Id] = role.Name }
    @profiles = Profile.all
    @profiles.each { |profile| @profilenames[profile.Id] = profile.Name}   
    session[:roles] = @rolenames
    session[:profiles] = @profilenames
    @rolenames = Hash[session[:roles].sort_by {|k,v| v}]
    @profilenames = Hash[session[:profiles].sort_by {|k,v| v}]
  end
  
  def get_search_criteria
    # replace role and profile with their corresponding ids
    criteria = Hash.new
    params[:name].blank? ?  criteria.except['name'] : criteria['name'] = params[:name].split()[0].capitalize 
    if params['role'] != 'All' then  criteria['role'] = session[:roles].key(params[:role]) end
    if params['profile'] != 'All'  then criteria['profile'] = session[:profiles].key(params[:profile])  end
    params[:active] == "1" ?  criteria['active'] = true :  criteria['active'] = false
    criteria
  end
  
  def result
    criteria = get_search_criteria
    criteriastring = ''
    userId= Array.new
    criteriastring = "FirstName = '#{criteria['name']}' and " if criteria['name']
    criteriastring = criteriastring + "UserRoleId = '#{criteria['role']}' and " if criteria['role']
    criteriastring = criteriastring + "ProfileId = '#{criteria['profile']}' and " if criteria['profile']
    criteriastring = criteriastring + "IsActive = #{criteria['active']} and " 
     if criteriastring.length > 0  
       criteriastring = criteriastring[0..-5]
     end
     
      @users= User.query(criteriastring)
      @users.each do |user| 
        user = user.Id[0..-4]
        userId.push(user)
      end
       session[:users] = @users
    #  @result = Pardb.find_all_by_sfdc_id(userId, :select => "id, par_un, par_pw")
    #  @result.each{ |res| session[:id] = res.id}
  end
   def edit
     p params[:id]
     
     @users = Array.new
     @user = Array.new
     @users = session[:users]
     @users.each do |user|
       if user.Id == params[:id]
        @user.push(user)
         
       end
     end
     
     @rolenames = Hash[session[:roles].sort_by {|k,v| v}]
     @profilenames = Hash[session[:profiles].sort_by {|k,v| v}]
     p @user
  end
  def save
    session[:roles] = params[:roles]
    session[:profiles] = params[:profiles] 
    update_hash = Hash.new
      p "update"
   # update_hash["Name"] = params[:name]
    update_hash["Email"] = params[:email]
    update_hash["IsActive"] = params[:active] == "true" ? true : false
     update_hash["UserRoleId"] = session[:roles].key(params[:role]) if params[:role] != "All"
    update_hash["ProfileId"] = session[:profiles].key(params[:profile]) if params[:profile] != "All"
    User.upsert("Id", params[:id], update_hash)
    redirect_to :controller => 'user', :action => "index"
  end

end
