class WelcomeController < ApplicationController
  def index
    @title = [ "Please select..." , "Mr", "Ms", "Miss", "Mrs", "Dr"]
 #   @register = Register.new
  #  @register = Salesforce::Register.new
  end
  
   

  def create
    @title = [ "Please select..." , "Mr", "Ms", "Miss", "Mrs", "Dr"]
    p params
    if params[:commit] == "Cancel"
      p "cancel"
    else
      register = Hash.new
  #   @register = Salesforce::Register.new(params[:register])
  #   @register = Register.new(params['register'])
      register = params.except(:commit, :authenticity_token)
      p "register", register
      params[:register] = register
      save_registration
    end
   end
    def save_registration
   p "save"
    @mapped_hash = Hash.new
    @mapped_hash = params['register']
    @mapped_hash[:title] = "Mr" if @mapped_hash[:title] == "Please select..."
    p "mapped", @mapped_hash
    
    # based on the CRN and SPID provided trace the account details
    get_account_number(@mapped_hash)
    get_account_number_user(@mapped_hash)
   # compare_accountIds(@result_hash, @user_hash) if ((@user_hash.blank? == false) and (@result_hash.blank? == false))
  #   check_user(client)
   # create a new customer portal
    create_new_cp_record(@mapped_hash)
    
    # email a new username and password
    
  #  UserMailer.deliver_registration_confirmation(@mapped_hash)
    p "sent mail"
  end
  
  def get_account_number(mapped_hash)
    begin
     # accounts = client.materialize("Account")
 #   sites = client.materialize("Site__c")
 
   p   @result_hash = Salesforce::SfBase.query_by_sql("SELECT account__c, name from Site__c where (crn__c = '#{mapped_hash["crn"]}' ) OR (SPID__c = '#{mapped_hash["spid"] }')")
   #   @result_hash = client.query("SELECT account__c, name from Site__c where (crn__c = '#{mapped_hash["crn"]}' ) OR (SPID__c = '#{mapped_hash["spid"] }')")
       p "result_hash", @result_hash
       mapped_hash["accId"] = @result_hash.Account__c
   #   site_accId = get_accId( @result_hash)
   #   mapped_hash["accId"] = site_accId[0]
      @mapped_hash = mapped_hash
      p "mh",  @mapped_hash
    rescue Exception => e
      p "RESCUE1"
      p e
      # handle exception here if CRN not found in site__c
      begin
      #  p "mh", mapped_hash["spid"] 
      #  @result_hash = client.query("SELECT accountId from Site__c where spid__c = '#{mapped_hash["spid"]}' ")
      # site_accId = get_accId( @result_hash)
      # mapped_hash["accId"] = site_accId[0]
      # @mapped_hash = mapped_hash
      rescue Exception => e
      p e
      p "rescue 2"
      # handle exception here if CRN not found in site__c
      end
    end
    
  end
  def get_account_number_user(mapped_hash)
    
     begin
       p "checking user"
 #       users = client.materialize("User")
      p @user_hash= Salesforce::SfBase.query_by_sql("SELECT Id, Name, AccountId, Email, UserName from User where username = '#{mapped_hash["email"] }' ")
      # p @user_hash= client.query("SELECT Id, Name, AccountId, Email, UserName from User where username = '#{mapped_hash["email"] }' ")
      if @user_hash.nil?
        p "need to enter contact details"
       insert_contact_details(mapped_hash)
       else
         p "comparing account Ids"
         compare_accountIds(@result_hash, @user_hash)
      end
     rescue Exception => e
      p "rescue 3"
      p e
      # handle exception here if id not found in user by creating new user
     p "contact not found need to enter contact details"
   #   insert_contact_details(mapped_hash)
    end
  end
 
  def get_accId(result_hash)
    site_accountId = Array.new
    result_hash.each {|rec| site_accountId.push(rec.Account__c)}
    site_accountId
  end
  def compare_accountIds(result_hash, user_hash)
  #  p "result_hash.Id", result_hash
  #  p "user_hash.AccountId", user_hash
    # %%%%%%%%%%%%%%%%%%%%  do we need to update any fields based on the data collected for the user??&&&&&&&
    site_accountId = ""
    user_accountId = ""
    contactId = ""
  # p site_accountId = get_accId(result_hash)
      site_accountId = result_hash.Account__c
 #   user_hash.each do |rec| 
      user_accountId = user_hash.AccountId
      contactId = user_hash.Id[0]
 #   end
  #  registered = site_accountId & user_accountId
  #  if registered.empty?
    if site_accountId == user_accountId
      # handle user registered to different account
      p " user found and registered to correct account"
      # need to capture contact Id for portal user registration
    else
      # handle user exists
      p "user found but registered to different  account"
      # need to capture contact Id for portal user registration
    end
   p @contactId = contactId
  end
  def insert_contact_details(mapped_hash)
    p mapped_hash
    p "inserting contact"
 #   contacts = client.materialize("Contact")
    newrec = Salesforce::Contact.new({"first_name" => "#{mapped_hash['fname']}","last_name" => "#{mapped_hash['lname']}", 
            "email" => "#{mapped_hash['email']}", "salutation" => "#{mapped_hash['title']}",
            "phone" => "#{mapped_hash['landline']}","account_id" => "#{mapped_hash['accId']}" } )
   # newrec = client.create("Contact", {"FirstName" => "#{mapped_hash['fname']}","LastName" => "#{mapped_hash['lname']}", 
   #         "Email" => "#{mapped_hash['email']}", "Salutation" => "#{mapped_hash['title']}",  
   #         "Phone" => "#{mapped_hash['landline']}","AccountId" => "#{mapped_hash['accId']}" } )
    p "done"
  p  @contactId = newrec.Id
    
  end
  def create_new_cp_record(mapped_hash)
    user_values = Hash.new
    al = ""
    contactId = profileId = " "
    
    fname = mapped_hash['fname']
    lname = mapped_hash['lname']
    #accId = "001W0000002SKmz"
    al = fname[0].to_s+lname[0..2].to_s
    contactId = @contactId
#    profiles = client.materialize("Profile")
   p  "profiles", profile =  Salesforce::SfBase.query_by_sql("select id from profile where name = 'Overage Customer Portal Manager Standard'")
   #  profile.each {|rec| profileId = rec.Id }
    profileId = profile.Id[0] 
    user_values= {"username" => "#{mapped_hash['email']}","email" => "#{mapped_hash['email']}", "last_name" => "#{mapped_hash['lname']}",  "first_name" => "#{mapped_hash['fname']}",
    "alias" => "#{al}",  "contact_id" => "#{contactId}",
    "is_portal_self_registered" => true, "portal_role" => "Worker", "profile_id" => "#{profileId}", "email_encoding_key" => "UTF-8",
    "locale_sid_key" => "en_GB",  "language_locale_key" => "en_US", "time_zone_sid_key" => "Europe/London","user_permissions_marketing_user" => false, "user_permissions_offline_user" => false}
    p "user_values" , user_values
   # newUser = client.create("User", user_values)
     newUser = Salesforce::User.new(user_values)
    p "done"
    userId = newUser.id
  end
  
  def check_user(client)
    name = Array.new
    @rest_hash = client.describe_sobject("User")
    @res_hash = @rest_hash['fields']
    
  end
  
  
end
