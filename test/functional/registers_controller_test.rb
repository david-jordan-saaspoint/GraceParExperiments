require 'test_helper'

class RegistersControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Register.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Register.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Register.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to register_url(assigns(:register))
  end

  def test_edit
    get :edit, :id => Register.first
    assert_template 'edit'
  end

  def test_update_invalid
    Register.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Register.first
    assert_template 'edit'
  end

  def test_update_valid
    Register.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Register.first
    assert_redirected_to register_url(assigns(:register))
  end

  def test_destroy
    register = Register.first
    delete :destroy, :id => register
    assert_redirected_to registers_url
    assert !Register.exists?(register.id)
  end
end
