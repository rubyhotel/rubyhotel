class EmployeeportalController < ApplicationController

  # GET /employeeportal/1
  # GET /employeeportal/1.json
  def index
    query = "SELECT * FROM Employee INNER JOIN Location ON Employee.locationId=Location.locationId "\
            "WHERE employeeId = #{params[:id]}"
    @employee = Employee.find_by_sql(query).first

    query = "SELECT * FROM Location INNER JOIN Reserve ON Location.locationId=Reserve.locationId "\
            "INNER JOIN Booking ON Reserve.bookingId=Booking.bookingId "\
            "WHERE Location.locationId=#{@employee[:locationId]}"
    @rooms = Room.find_by_sql(query)

    query = "SELECT COUNT(*) FROM Booking INNER JOIN Reserve ON Booking.bookingId=Reserve.locationId "\
            "WHERE Reserve.locationId=#{@employee[:locationId]}"
    @roomCount = Booking.find_by_sql(query).first['COUNT(*)']

  end

  def search
    if params[:gid] == ''
      puts 'Guest ID for search cannot be blank.'
      redirect_to eportal_path :id => params[:id], :error => true
    else
      query = "SELECT guestId FROM Guest WHERE Guest.guestId = #{params[:gid]}"
      @guests = Guest.find_by_sql(query)

      redirect_to "/employeeportal/#{params[:id]}/guesthelp/#{params[:gid]}"
    end
  end

  # GET /guests/guestsearch/:gid
  def helper
    query = "SELECT * FROM Guest WHERE Guest.guestId=#{params[:gid]}"
    @guest = Guest.find_by_sql(query).first

    query = "SELECT * FROM Booking INNER JOIN Reserve ON Booking.bookingId=Reserve.bookingId "\
            "INNER JOIN Location ON Reserve.locationId=Location.locationId "\
            "WHERE Reserve.guestId=#{params[:gid]}"
    @gbookings = Booking.find_by_sql(query)
  end

  # GET /guests/1/edit
  def edit
    query = "SELECT * FROM Booking WHERE Booking.bookingId=#{params[:bid]}"
    @booking = Booking.find_by_sql(query).first
  end

  def editpost
    indate = "#{booking_params["inDate(1i)"]}" + "-" "#{booking_params["inDate(2i)"]}" + "-" "#{booking_params["inDate(3i)"]}" + "-" "#{booking_params["inDate(4i)"]}" + "-" "#{booking_params["inDate(5i)"]}"

    outdate = "#{booking_params["outDate(1i)"]}" + "-" "#{booking_params["outDate(2i)"]}" + "-" "#{booking_params["outDate(3i)"]}" + "-" "#{booking_params["outDate(4i)"]}" + "-" "#{booking_params["outDate(5i)"]}"

    cost = booking_params[:cost] ? "cost = '#{booking_params[:cost]}', " : ""

    sql = "UPDATE Booking SET " + cost +
          "inDate = '#{indate}', " \
          "outDate = '#{outdate}', " \
          "numOfGuests = '#{booking_params[:numOfGuests]}' " \
          "WHERE bookingId = #{params[:id]}"

    rows_updated = ActiveRecord::Base.connection.exec_update(sql)

    query = "SELECT * FROM Booking WHERE bookingId = #{params[:id]}"
    @booking = Booking.find_by_sql(query).first

    respond_to do |format|
      if rows_updated == 1
        format.html { redirect_to @booking, notice: 'Booking was successfully updated.' }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    query = "SELECT * FROM Booking WHERE Booking.bookingId=#{params[:bid]}"
    @booking = Booking.find_by_sql(query).first
  end

  def new
  end

  def newpost
    # get location
    query = "SELECT locationId FROM Employee WHERE Employee.employeeId=#{params[:id]}"
    locationId = ActiveRecord::Base.connection.exec_query(query).first['locationId']

    # format dates
    indate = "#{booking_params["inDate(1i)"]}" + "-" "#{booking_params["inDate(2i)"]}" + "-" "#{booking_params["inDate(3i)"]}" + "-" "#{booking_params["inDate(4i)"]}" + "-" "#{booking_params["inDate(5i)"]}"
    outdate = "#{booking_params["outDate(1i)"]}" + "-" "#{booking_params["outDate(2i)"]}" + "-" "#{booking_params["outDate(3i)"]}" + "-" "#{booking_params["outDate(4i)"]}" + "-" "#{booking_params["outDate(5i)"]}"
    cost = 50 * params[:numOfGuests].to_f

    # check that an unbooked room for the given dates exists
    roomSql = "SELECT r.roomNum FROM Room r JOIN Location l ON r.locationId = l.locationId WHERE (r.locationId = #{locationId}) AND (r.roomNum NOT IN (SELECT res.roomNum FROM Reserve res JOIN Booking b ON res.bookingId = b.bookingId WHERE res.locationId = #{locationId} AND (('#{indate}' >= b.inDate AND '#{indate}'  < b.outdate) OR ('#{indate}' <= b.indate AND '#{outdate}' >= b.outdate) OR     ('#{indate}' <= b.indate AND '#{outdate}'  > b.indate) OR     ('#{indate}'  >= b.indate AND '#{outdate}' <= b.outdate))))"
    roomNum = ActiveRecord::Base.connection.exec_query(roomSql).first

    if roomNum.nil?
      puts 'No room available for the given dates'
      redirect_to new_ghelper_path(:id => params[:id], :gid => params[:gid]), :notice => "No room available for the given dates"
    else
      roomNumVal = roomNum['roomNum']

      # insert new booking
      sql = "INSERT INTO Booking (cost, inDate, outDate, numOfGuests) " \
          "VALUES (#{cost}, '#{indate}', " \
          "'#{outdate}', #{params[:numOfGuests]})"
      ActiveRecord::Base.connection.exec_insert(sql)

      sql = 'SELECT LAST_INSERT_ID()'
      bookingId = ActiveRecord::Base.connection.exec_query(sql).first['LAST_INSERT_ID()']

      # insert new reservation
      sql = "INSERT INTO Reserve (bookingId, roomNum, locationId, guestId) " \
      "VALUES (#{bookingId}, #{roomNumVal}, #{locationId}, #{params[:gid]})"
      ActiveRecord::Base.connection.exec_insert(sql)
      redirect_to ghelper_path(:id => params[:id], :gid => params[:gid]), :notice => "Successfully added new booking."
    end

  end

  # DELETE /guests/1
  # DELETE /guests/1.json
  def destroy
    query = "DELETE FROM Booking WHERE Booking.bookingId = #{params[:bid]}"
    ActiveRecord::Base.connection.execute(query)

    respond_to do |format|
      format.html { redirect_to ghelper_path(:id => params[:id], :gid => params[:gid]), notice: 'Booking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def booking_params
    params.permit(:cost, :inDate, :outDate, :numOfGuests)
  end

end
