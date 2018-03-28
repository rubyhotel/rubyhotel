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
    query = "SELECT guestId FROM Guest WHERE Guest.guestId = #{params[:gid]}"
    @guests = Guest.find_by_sql(query)

    redirect_to "/guests/#{params[:gid]}"

  end

  # GET /guests/new
  def new
    @guest = Guest.new
  end

  # GET /guests/1/edit
  def edit
  end

  # POST /guests
  # POST /guests.json
  def create
    sql = "INSERT INTO Guest (name, phoneNum, creditCardNum) " \
    "VALUES ('#{guest_params[:name]}', '#{guest_params[:phoneNum]}', '#{guest_params[:creditCardNum]}')"
    ActiveRecord::Base.connection.exec_insert(sql)

    key_query = 'SELECT LAST_INSERT_ID()'
    pkey = ActiveRecord::Base.connection.execute(key_query).first.first

    query = "SELECT * FROM Guest WHERE guestId = #{pkey}"
    results = Guest.find_by_sql(query)

    respond_to do |format|
      if results.length == 1
        @guest = results.first
        format.html { redirect_to @guest, notice: 'Guest was successfully created.' }
        format.json { render :index, status: :created, location: @guest }
      else
        format.html { render :new }
        format.json { render json: @guest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /guests/1
  # PATCH/PUT /guests/1.json
  def update
    sql = "UPDATE Guest SET " \
    "name = '#{guest_params[:name]}', " \
    "phoneNum = '#{guest_params[:phoneNum]}', " \
    "creditCardNum = '#{guest_params[:creditCardNum]}' " \
    "WHERE guestId = #{params[:id]}"
    rows_updated = ActiveRecord::Base.connection.exec_update(sql)

    query = "SELECT * FROM Guest WHERE guestId = #{params[:id]}"
    @guest = Guest.find_by_sql(query).first

    respond_to do |format|
      if rows_updated == 1
        format.html { redirect_to @guest, notice: 'Guest was successfully updated.' }
        format.json { render :index, status: :ok, location: @guest }
      else
        format.html { render :edit }
        format.json { render json: @guest.errors, status: :unprocessable_entity }
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

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_guest
    query = "SELECT * FROM Guest WHERE guestId = #{params[:id]}"
    @guest = Guest.find_by_sql(query).first
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def guest_params
    params.require(:guest).permit(:name, :phoneNum, :creditCardNum)
  end
end
