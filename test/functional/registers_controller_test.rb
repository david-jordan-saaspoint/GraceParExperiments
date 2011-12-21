require 'test_helper'

class RegistersControllerTest < ActionController::TestCase
  

  def test_reregister
    session[:mh] = {"title" => "Mr", "fname" => "Test" , "lname" => "rails" , "email" => "test@rail.com" , "crn" => "2088376", "spid" => "100125120100",
    "landline" => "12123334231"}
    get :reregister
    assert_template 'reregister'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    @input_attrib = {
    "title" => "Mr", "fname" => "Test", "lname" => "rails"
  }
    Register.any_instance.stubs(:valid?).returns(false)
    post :create, :register => @input_attrib
  #  assert_template 'create'
  end
  def test_create
    @input_attrib = {
    "title" => "Mr", "fname" => "Test", "lname" => "rails", "email" => "test@rails.com", "crn" => "2088376", "spid" => "100125120100",
    "landline" => "12123334231"
  }
    post :create, :register => @input_attrib
     assert_template 'new'
  end

  def test_create_valid
    @input_attrib = {
    "title" => "Mr", "fname" => "Test", "lname" => "rails", "email" => "test@rails.com", "crn" => "2088376", "spid" => "100125120100",
    "landline" => "12123334231"
  }
    Register.any_instance.stubs(:valid?).returns(true)
    post :create, :register => @input_attrib
    assert_template 'create'
  #  assert_redirected_to register_url(assigns(:register))
  end
end
