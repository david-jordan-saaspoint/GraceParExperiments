require 'test_helper'

class Salesforce::ContactsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:salesforce_contacts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contact" do
    assert_difference('Salesforce::Contact.count') do
      post :create, :contact => { }
    end

    assert_redirected_to contact_path(assigns(:contact))
  end

  test "should show contact" do
    get :show, :id => salesforce_contacts(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => salesforce_contacts(:one).to_param
    assert_response :success
  end

  test "should update contact" do
    put :update, :id => salesforce_contacts(:one).to_param, :contact => { }
    assert_redirected_to contact_path(assigns(:contact))
  end

  test "should destroy contact" do
    assert_difference('Salesforce::Contact.count', -1) do
      delete :destroy, :id => salesforce_contacts(:one).to_param
    end

    assert_redirected_to salesforce_contacts_path
  end
end
