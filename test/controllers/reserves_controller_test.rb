require 'test_helper'

class ReservesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @reserf = reserves(:one)
  end

  test "should get index" do
    get reserves_url
    assert_response :success
  end

  test "should get new" do
    get new_reserf_url
    assert_response :success
  end

  test "should create reserf" do
    assert_difference('Reserf.count') do
      post reserves_url, params: { reserf: { Booking_id: @reserf.Booking_id, Guest_id: @reserf.Guest_id, Location_id: @reserf.Location_id, Room_id: @reserf.Room_id } }
    end

    assert_redirected_to reserf_url(Reserf.last)
  end

  test "should show reserf" do
    get reserf_url(@reserf)
    assert_response :success
  end

  test "should get edit" do
    get edit_reserf_url(@reserf)
    assert_response :success
  end

  test "should update reserf" do
    patch reserf_url(@reserf), params: { reserf: { Booking_id: @reserf.Booking_id, Guest_id: @reserf.Guest_id, Location_id: @reserf.Location_id, Room_id: @reserf.Room_id } }
    assert_redirected_to reserf_url(@reserf)
  end

  test "should destroy reserf" do
    assert_difference('Reserf.count', -1) do
      delete reserf_url(@reserf)
    end

    assert_redirected_to reserves_url
  end
end
