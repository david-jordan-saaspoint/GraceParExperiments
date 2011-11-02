require 'test_helper'

class SfdcsControllerTest < ActionController::TestCase
  setup do
    @sfdc = sfdcs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sfdcs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sfdc" do
    assert_difference('Sfdc.count') do
      post :create, :sfdc => @sfdc.attributes
    end

    assert_redirected_to sfdc_path(assigns(:sfdc))
  end

  test "should show sfdc" do
    get :show, :id => @sfdc.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @sfdc.to_param
    assert_response :success
  end

  test "should update sfdc" do
    put :update, :id => @sfdc.to_param, :sfdc => @sfdc.attributes
    assert_redirected_to sfdc_path(assigns(:sfdc))
  end

  test "should destroy sfdc" do
    assert_difference('Sfdc.count', -1) do
      delete :destroy, :id => @sfdc.to_param
    end

    assert_redirected_to sfdcs_path
  end
end
