  require 'rubygems'
  require 'httparty'
  require 'nokogiri'
  require 'open-uri'
  require 'databasedotcom'
  require 'uri'
class UserController < ApplicationController

  def index
    
    client = Databasedotcom:: Client.new 
    client.authenticate(:options => nil, :token => session[:sid], :instance_url => session[:uri])
    users = client.materialize("User")
    roles = client.materialize("UserRole")
    profiles = client.materialize("Profile")
    @users = User.all
    
    userId = "005U0000000Ymtl"
    @result = Pardb.find_by_sfdc_id(userId, :select => "par_un, par_pw")
  end
  def search
    
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
    @rolenames = Hash[@rolenames.sort_by {|k,v| v}]
    @profilenames = Hash[@profilenames.sort_by {|k,v| v}]
   end
  def get_search_criteria
    # replace role and profile with their corresponding ids
    criteria = Hash.new
    params[:name].blank? ?  criteria.except['name'] : criteria['name'] = params[:name] 
    if params['role'] != 'All' then  criteria['role'] = session[:roles].key(params[:role]) end
    if params['profile'] != 'All'  then criteria['profile'] = session[:profiles].key(params[:profile])  end
    params[:active] == "1" ?  criteria['active'] = true :  criteria['active'] = false
    criteria
  end
  
  def result
    criteria = get_search_criteria
    criteriastring = ''
    userId= Array.new
    p "results", criteria
     # @users= User.query("IsActive = true")
    #  User.find_all_by_Name("#{criteria['name']}", "#{criteria['role']}")
   #  @users= User.query(criteriastring)
      @users = User.query( "Name = '#{criteria['name']}'" && "UserRoleId = '#{criteria['role']}'"  && "ProfileId = '#{criteria['profile']}'" && "IsActive = #{criteria['active']}")
      @users.each do |user| 
        user = user.Id[0..-4]
        userId.push(user)
      end
       
      @result = Pardb.find_all_by_sfdc_id(userId, :select => "id, par_un, par_pw")
      @result.each{ |res| session[:id] = res.id}
  end
  def update
    p params[:commit]
    p "update"
    p session[:id]
    p params[:parusername]
    p params[:parpassword]
     Pardb.update(session[:id], :par_un => params[:parusername], :par_pw => params[:parpassword])
   redirect_to :controller => 'user', :action => "index"
  end
end
