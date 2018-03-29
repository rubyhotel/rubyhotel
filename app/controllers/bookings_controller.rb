class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  # GET /bookings
  # GET /bookings.json
  def index
    query = 'SELECT * FROM Booking'
    @bookings = Booking.find_by_sql(query)
  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show
    query = "SELECT * FROM Booking WHERE bookingId = #{@booking[:bookingid]}"
    @booking = Booking.find_by_sql(query).first
  end

  # GET /bookings/new
  def new
    @booking = Booking.new
  end

  # GET /bookings/1/edit
  def edit
  end

  # POST /bookings
  # POST /bookings.json
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

  # PATCH/PUT /bookings/1
  # PATCH/PUT /bookings/1.json
  def update
    sql = "UPDATE Booking SET " \
    "cost = #{booking_params[:cost]}, " \
    "inDate = '#{booking_params[:inDate]}', " \
    "outDate = '#{booking_params[:outDate]}', " \
    "numOfGuests = #{booking_params[:numOfGuests]} " \
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

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
    sql = "DELETE FROM Booking WHERE bookingId = #{params[:id]}"
    ActiveRecord::Base.connection.execute(sql)

    respond_to do |format|
      format.html { redirect_to bookings_url, notice: 'Booking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      query = "SELECT * FROM Booking WHERE bookingId = #{params[:id]}"
      @booking = Booking.find_by_sql(query).first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def booking_params
      params.require(:booking).permit(:cost, :inDate, :outDate, :numOfGuests)
    end
end
