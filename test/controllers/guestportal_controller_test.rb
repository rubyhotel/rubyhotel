require 'test_helper'

class GuestportalControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get guestportal_index_url
    assert_response :success
  end

end
