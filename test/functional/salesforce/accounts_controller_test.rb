require 'test_helper'

class Salesforce::AccountsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:salesforce_accounts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create account" do
    assert_difference('Salesforce::Account.count') do
      post :create, :account => { }
    end

    assert_redirected_to account_path(assigns(:account))
  end

  test "should show account" do
    get :show, :id => salesforce_accounts(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => salesforce_accounts(:one).to_param
    assert_response :success
  end

  test "should update account" do
    put :update, :id => salesforce_accounts(:one).to_param, :account => { }
    assert_redirected_to account_path(assigns(:account))
  end

  test "should destroy account" do
    assert_difference('Salesforce::Account.count', -1) do
      delete :destroy, :id => salesforce_accounts(:one).to_param
    end

    assert_redirected_to salesforce_accounts_path
  end
end
