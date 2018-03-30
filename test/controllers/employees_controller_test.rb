require 'test_helper'

class EmployeesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @employee = employees(:one)
  end

  test "should get index" do
    get employees_url
    assert_response :success
  end

  test "should get new" do
    get new_employee_url
    assert_response :success
  end

  test "should create employee" do
    assert_difference('Employee.count') do
      post employees_url, params: { employee: { Location_id: @employee.Location_id, hourlyRate: @employee.hourlyRate, name: @employee.name, phoneNum: @employee.phoneNum, position: @employee.position, startDate: @employee.startDate } }
    end

    assert_redirected_to employee_url(Employee.last)
  end

  test "should index employee" do
    get employee_url(@employee)
    assert_response :success
  end

  test "should get edit" do
    get edit_employee_url(@employee)
    assert_response :success
  end

  test "should update employee" do
    patch employee_url(@employee), params: { employee: { Location_id: @employee.Location_id, hourlyRate: @employee.hourlyRate, name: @employee.name, phoneNum: @employee.phoneNum, position: @employee.position, startDate: @employee.startDate } }
    assert_redirected_to employee_url(@employee)
  end

  test "should destroy employee" do
    assert_difference('Employee.count', -1) do
      delete employee_url(@employee)
    end

    assert_redirected_to employees_url
  end
end
