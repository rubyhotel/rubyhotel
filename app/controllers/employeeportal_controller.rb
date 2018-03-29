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

  def update

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

  # POST /guests
  # POST /guests.json
  def create
    sql = "INSERT INTO Booking (cost, inDate, outDate, numOfGuests) " \
    "VALUES (#{booking_params[:cost]}, '#{booking_params[:inDate]}', " \
    "'#{booking_params[:outDate]}', #{booking_params[:numOfGuests]})"
    ActiveRecord::Base.connection.exec_insert(sql)

    key_query = 'SELECT LAST_INSERT_ID()'
    pkey = ActiveRecord::Base.connection.execute(key_query).first.first

    query = "SELECT * FROM Booking WHERE bookingId = #{pkey}"
    results = Location.find_by_sql(query)

    respond_to do |format|
      if results.length == 1
        @booking = results.first
        format.html { redirect_to @booking, notice: 'Booking was successfully created.' }
        format.json { render :show, status: :created, location: @booking }
      else
        format.html { render :new }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /guests/1
  # DELETE /guests/1.json
  def destroy
    sql = "DELETE FROM Guest WHERE guestId = #{params[:id]}"
    ActiveRecord::Base.connection.execute(sql)

    respond_to do |format|
      format.html { redirect_to guests_url, notice: 'Guest was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

end
