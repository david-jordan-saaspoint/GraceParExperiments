require 'test_helper'

class UserControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get search" do
    get :search
    assert_response :success
  end

  test "should get update" do
    get :update
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

end
