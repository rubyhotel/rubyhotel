require 'test_helper'

class EmployeeportalControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get employeeportal_index_url
    assert_response :success
  end

end
