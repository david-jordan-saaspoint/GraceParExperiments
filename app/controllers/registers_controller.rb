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
   
    mapped_hash = Hash.new
    mapped_hash = params['register']
    mapped_hash[:title] = "Mr" if mapped_hash[:title] == "Please select..."
    p "mapped", mapped_hash
    
    # based on the CRN and SPID provided trace the account details
    # based on the account record upsert contact details
    # create a new customer portal
    # email a new username and password
  end
  
end
