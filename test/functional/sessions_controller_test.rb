require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should get create" do
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(:forcedotcom, {:uid => '12345'})
   # get :create
    assert_response :success
  end

end
