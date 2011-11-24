class UsersController < ApplicationController
  include Databasedotcom::Rails::Controller
 # before_filter :verify_configuration
  def index
    @users = User.all
  end

  def new
    @user = User.new "ProfileId" => Profile.first.Id
  end

  def create
    User.create User.coerce_params(params[:user])
    redirect_to  users_path
  end
  
  
  
end
