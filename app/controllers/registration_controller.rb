class RegistrationController < ApplicationController
  def register
    @title = [ "Please select..." , "Mr", "Ms", "Miss", "Mrs", "Dr"]
  end
  def save
    p "save"
    p params
    mapped_hash = Hash.new
    p mapped_hash = params.except(:controller, :action)
    mapped_hash[:title] = "Mr" if mapped_hash[:title] == "Please select..."
    @registration = mapped_hash
    p "registration" , @registration
    if @registration[:firstname].empty? == false
      p "fasle"
      flash[:notice] = "Message sent! Thank you for contacting us."
      redirect_to root_url
    else
      p "here"
       @title = [ "Please select..." , "Mr", "Ms", "Miss", "Mrs", "Dr"]
      @error = "Required fields missing values"
      render :action => 'register'
    end
       
  end
  def login
    @message= "login"
  end
end
