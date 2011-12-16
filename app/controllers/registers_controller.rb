require 'rubygems'
require 'databasedotcom'
require 'httparty'
gem 'soap4r'
require 'soap/soap'
require 'defaultDriver'
require 'client_auth_header_handler'
require 'soap/wsdlDriver'
# require 'open-uri'
#  require 'uri'
class RegistersController < ApplicationController
  
  def new
    @title =  [["Please select...", ""] , "Mr", "Ms", "Miss", "Mrs"]
    @register = Register.new
    
  end
  def reregister
  p  @mapped_hash = session[:mh]
  flash[:notice] = ["Please enter a valid customer reference number and Supply point ID. The billing account cannot be identified. "]
     @title =  [["Please select...", ""] , "Mr", "Ms", "Miss", "Mrs"] 
     @register = Register.new
     @register.title = @mapped_hash['title']
     @register.fname = @mapped_hash['fname']
     @register.lname = @mapped_hash['lname']
     @register.email = @mapped_hash['email']
     @register.landline = @mapped_hash['landline']
     @register.mobile = @mapped_hash['mobile']
     @register.crn = @mapped_hash['crn']
     @register.spid = @mapped_hash['spid']
     @register.mail = @mapped_hash['mail']
     @register.phone = @mapped_hash['phone']
     @register.email1 = @mapped_hash['email1']
     @register.none = @mapped_hash['none']
    
  end
  
  def create
    if params['commit'] == "Sign me up >>"
      flash[:notice] = ["Saving Registration "]
     
      @title = [["Please select...", ""] , "Mr", "Ms", "Miss", "Mrs"]
      @register = Register.new(params['register'])
      if @register.valid?
        # TODO send message here
        save_registration
      else
        render :action => 'new'
     end
    else # user clicks 'cancel'
      redirect_to "http://www.business-stream.co.uk/"
    end
  end
  def save_registration
    
   p "save"
    @mapped_hash = Hash.new
    @mapped_hash = params['register']
    @mapped_hash[:title] = "Mr" if @mapped_hash[:title] == "Please select..."
    @mapped_hash
    
    # based on the CRN and SPID provided trace the account details
    if client
      p "client"
      get_account_number(@mapped_hash,client)
      get_account_number_user(@mapped_hash, client) if @result_hash.empty? ==false
 #     compare_accountIds(@result_hash, @user_hash) if ((@user_hash.blank? == false) and (@result_hash.blank? == false))
      #   check_user(client)
      # create a new customer portal
      #create_new_cp_record(@mapped_hash, client)
      # email a new username and password
 #     @mapped_hash['passwd'] = @newpasswd
  #    UserMailer.deliver_registration_confirmation(@mapped_hash) if @result_hash.empty? == false
  #    p "sent mail"
    else
      flash[:notice] << "database connection not established. Contact Administrator"
      redirect_to "/reg_failed"
     end
  end
  def registration_failed
    p "registration failed"
    p @mapped_hash = session[:mh]
  end
  def get_account_number(mapped_hash, client)
    @result_hash = Hash.new
    begin
       accounts = client.materialize("Account")
      #sites = client.materialize("Site__c")
      #  @result_hash = client.query("SELECT id from Account")
      # @result_hash = d.query(:queryString => "SELECT account__c, name from Site__c where (crn__c = '#{mapped_hash["crn"]}' ) OR (SPID__c = '#{mapped_hash["spid"] }')")
      @result_hash = client.query("SELECT account__c, name from Site__c where (name = '#{mapped_hash["crn"]}' ) AND ((Waste_Water_SPID__c = '#{mapped_hash["spid"] }') OR (Water_SPID__c = '#{mapped_hash["spid"] }' ))")
      @result_hash
      
     
      if @result_hash.empty? == true
        p " Please enter a valid customer reference number and Supply point ID"
        flash[:message] = " Please enter a valid customer reference number and Supply point ID. The billing account cannot be identified. "
        session[:mh] = @mapped_hash
        redirect_to "/reg_failed"
      else
        p "else"
      
        site_accId = get_accId( @result_hash)
        mapped_hash["accId"] = site_accId[0]
        @mapped_hash = mapped_hash
        @mapped_hash
      
       end
       
    rescue Exception => e
      p "RESCUE1"
      p e
      flash[:message] = "Site__c raised exception"
      redirect_to "/reg_failed"
    end
    
  end
  def get_account_number_user(mapped_hash, client)
      begin
       p "checking user"
        users = client.materialize("User")
        @user_hash= client.query("SELECT Id, Name, AccountId, Email, UserName from User where username = '#{mapped_hash["email"] }' ")
      if @user_hash.empty?
       insert_contact_details(mapped_hash, client)
      else # what to do if the user is already registered
        compare_accountIds(@result_hash, @user_hash)
        
      end
     rescue Exception => e
      p "rescue 3"
      p e
      # handle exception here if id not found in user by creating new user
      insert_contact_details(mapped_hash, client)
    end
  end
  
  def user_exists
    if session[:flag] == "R"
      flash[:message] = "You are a registered User"
    else
      flash[:message] = "You are registered against incorrect Account"
      p "Incorrect Account"
    end 
     
  end
 
  def get_accId(result_hash)
    p "get_acc"
    site_accountId = Array.new
    result_hash.each {|rec| site_accountId.push(rec.Account__c)}
    site_accountId
  end
  def compare_accountIds(result_hash, user_hash)
    flash[:notice] << "Checking Contact and Account Link"
  #  p "result_hash.Id", result_hash
  #  p "user_hash.AccountId", user_hash
    # %%%%%%%%%%%%%%%%%%%%  do we need to update any fields based on the data collected for the user??&&&&&&&
    site_accountId = Array.new
    user_accountId = Array.new
    contactId = ""
    site_accountId = get_accId(result_hash)
    user_hash.each do |rec| 
      user_accountId.push(rec.AccountId)
      contactId = rec.Id
    end
    registered = site_accountId & user_accountId
    if registered.empty?
      # handle user registered to different account
      p " user found but registered to different account"
      session[:flag] = "I"
      redirect_to "/user_exists"
      # need to capture contact Id for portal user registration
      
    else
      # handle user exists
      p "user found and registered to correct account"
      # need to capture contact Id for portal user registration
       session[:flag] = "R"
      redirect_to "/user_exists"
    end
   # @contactId = contactId
  end
  def insert_contact_details(mapped_hash, client)
    flash[:notice] << "Inserting new Contact "
    p mapped_hash
    p "inserting contact"
    # get contact preferences mapped
    mapped_hash['phone'] =="1" ? phone_pref = true : phone_pref = false
    mapped_hash['email1'] =="1" ? email_pref = true : email_pref = false
    mapped_hash['mail'] =="1" ? mail_pref = true :  mail_pref = false
    contacts = client.materialize("Contact")
  
    newrec = client.create("Contact", {"FirstName" => "#{mapped_hash['fname']}","LastName" => "#{mapped_hash['lname']}", 
            "Email" => "#{mapped_hash['email']}", "Salutation" => "#{mapped_hash['title']}",  
            "Phone" => "#{mapped_hash['landline']}","MobilePhone" => "#{mapped_hash['mobile']}","AccountId" => "#{mapped_hash['accId']}",
            "By_Mail__c" => mail_pref  , "By_Phone__c" => phone_pref, "By_E_mail__c" => email_pref } )
    p "done"
    @contactId = newrec.Id
    # create a contact_terms_child record
    create_contract_terms(@contactId, client)
    # create a new customer portal
    create_new_cp_record(@mapped_hash, client)
  end
  def create_contract_terms(contactId, client)
    termsId = ""    
    contract = client.materialize("Contact_terms__c")
    cont = client.query(" select id, terms_text__c from terms_and_conditions__c order by lastModifiedDate desc limit 1")
    cont.each {|rec| termsId = rec.Id }
    newContact_terms = client.create("Contact_terms__c", {"Contact__c" => "#{contactId}", "Terms_and_conditions__c" =>"#{termsId}" })
    p "done terms"
  end
  def create_new_cp_record(mapped_hash, client)
    flash[:notice] << "Inserting new Portal User"
    user_values = Hash.new
    contactId = profileId = " "
    fname = mapped_hash['fname']
    lname = mapped_hash['lname']
    #accId = "001W0000002SKmz"
    al = fname[0]+lname[0..2]
    contactId = @contactId
    profiles = client.materialize("Profile")
    profile = client.query("select id from profile where name = 'Overage Customer Portal Manager Standard'")
    profile.each {|rec| profileId = rec.Id }
    user_values= {"Username" => "#{mapped_hash['email']}","Email" => "#{mapped_hash['email']}", "LastName" => "#{mapped_hash['lname']}",  "FirstName" => "#{mapped_hash['fname']}",
    "Alias" => "#{al}",  "ContactId" => "#{contactId}",
    "IsPortalSelfRegistered" => true, "PortalRole" => "Worker", "ProfileId" => "#{profileId}", "EmailEncodingKey" => "UTF-8",
    "LocaleSidKey" => "en_GB",  "LanguageLocaleKey" => "en_US", "TimeZoneSidKey" => "Europe/London","UserPermissionsMarketingUser" => false, "UserPermissionsOfflineUser" => false}
    p "user_values" , user_values
 #   newUser = client.create("User", user_values)
    p "done"
    #userId = newUser.Id
    userId = "005W0000000Q8Sa"
    reset_password(userId)
    @mapped_hash['passwd'] = @newpasswd
    UserMailer.deliver_registration_confirmation(@mapped_hash) if @result_hash.empty? == false
    p "sent mail"
  end
  
  def check_user(client)
    name = Array.new
    @rest_hash = client.describe_sobject("User")
    @res_hash = @rest_hash['fields']
    
  end
  def reset_password(userId)
    user = 'grace.ramamoorthy@saaspoint.business-stream.com.regdev'
    passwd = 'Saaspoint12hUiejFhjFdoCAx5JWCObF3ZA'
    d = Soap.new
    h = ClientAuthHeaderHandler.new          # Create a new handler
    l = d.login(:username => user, :password => passwd)
    d.endpoint_url = l.result.serverUrl         # Change the endpoint to what login tells us it should be
    h.sessionid = l.result.sessionId              # Tell the header handler what the session id is
    d.headerhandler << h                          # Add the header handler to the Array of headerhandlers
    d.wiredump_dev = STDOUT
     
    user_Id = l.result.userId
   # result = d.getUserInfo("")
   # user_Id= d.getUserInfo("")['result']['userId']
    newpassword = d.resetPassword(userId:userId).result.password 
    @newpasswd = newpassword
    @newpasswd
    #d.query(:queryString=> "select id,name from 
  end
    
end
