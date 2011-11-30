require 'rubygems'

 require 'open-uri'
  require 'uri'
class RegistersController < ApplicationController
  
  def new
    @title = [ "Please select..." , "Mr", "Ms", "Miss", "Mrs", "Dr"]
    @register = Register.new
    
  end

  def create
     @title = [ "Please select..." , "Mr", "Ms", "Miss", "Mrs", "Dr"]
     @register = Register.new(params['register'])
    if @register.valid?
      # TODO send message here
      save_registration
      
    else
      render :action => 'new'
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
    # based on the account record upsert contact details
    upsert_contact_details
    # create a new customer portal
    create_new_cp_record
    
    # email a new username and password
    
    UserMailer.deliver_registration_confirmation(@mapped_hash)
    p "sent mail"
  end
  
  def get_account_number(mapped_hash)
  
    accounts = client.materialize("Account")
   p  result_hash= client.find(Account,"#{mapped_hash['crn'] }")
  end
  def upsert_contact_details
    
  end
  def create_new_cp_record
    
  end
  
end
