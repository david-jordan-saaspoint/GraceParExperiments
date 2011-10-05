require 'test_helper'

class SfdctablesControllerTest < ActionController::TestCase
  setup do
    @sfdctable = sfdctables(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sfdctables)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sfdctable" do
    assert_difference('Sfdctable.count') do
      post :create, :sfdctable => @sfdctable.attributes
    end

    assert_redirected_to sfdctable_path(assigns(:sfdctable))
  end

  test "should show sfdctable" do
    get :show, :id => @sfdctable.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @sfdctable.to_param
    assert_response :success
  end

  test "should update sfdctable" do
    put :update, :id => @sfdctable.to_param, :sfdctable => @sfdctable.attributes
    assert_redirected_to sfdctable_path(assigns(:sfdctable))
  end

  test "should destroy sfdctable" do
    assert_difference('Sfdctable.count', -1) do
      delete :destroy, :id => @sfdctable.to_param
    end

    assert_redirected_to sfdctables_path
  end
end
