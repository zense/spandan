require 'test_helper'

class RegistrationControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
