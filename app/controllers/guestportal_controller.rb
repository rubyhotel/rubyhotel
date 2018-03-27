class GuestportalController < ApplicationController
  def index

    query = "SELECT * FROM Guest WHERE guestId = #{params[:id]}"
    @guest = Guest.find_by_sql(query).first

    bookingquery = "SELECT * FROM Reserve r JOIN Booking b ON r.bookingId = b.bookingId WHERE r.guestId = #{params[:id]}"
    @bookings = ActiveRecord::Base.connection.exec_query(bookingquery).to_hash



  end

  def edit
  end
end
