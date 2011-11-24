require 'Users'
class UsersController < ApplicationController
  def index
    
  end
  def displayall
       @users = Users.get_first_ten['records']
  end
 
  def search
    @json = Users.search(params[:name])
  end
 
  def show
    @user = Users.retrieve(params[:id])
       
  end
 
  def create
     @user = Users.create
  end
 
  def edit
     @user = Users.retrieve(params[:id])
  end
 
 def new 
    @user = Users.get_first_ten
  end
  def save
    Users.save(params)
    redirect_to :action => :show, :id => params[:id]
  end  
 
  
end
