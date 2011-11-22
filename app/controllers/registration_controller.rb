class RegistrationController < ApplicationController
  def register
    @title = [ "Please select..." , "Mr", "Ms", "Miss", "Mrs", "Dr"]
  end
  def save
    p "save"
    p params
    mapped_hash = Hash.new
    p mapped_hash = params.except(:controller, :action)
    
  end
  def login
    @message= "login"
  end
end
