class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  # GET /locations
  # GET /locations.json
  def index
    query = 'SELECT * FROM Location'
    @locations = Location.find_by_sql(query)
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
    query = "SELECT * FROM Location WHERE locationId = #{params[:id]}"
    @location = Location.find_by_sql(query).first
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations
  # POST /locations.json
  def create
    sql = "INSERT INTO Location (address, phoneNum) " \
    "VALUES ('#{location_params[:address]}', '#{location_params[:phoneNum]}')"
    ActiveRecord::Base.connection.exec_insert(sql)

    key_query = 'SELECT LAST_INSERT_ID()'
    pkey = ActiveRecord::Base.connection.execute(key_query).first.first

    query = "SELECT * FROM Location WHERE locationId = #{pkey}"
    results = Location.find_by_sql(query)

    respond_to do |format|
      if results.length == 1
        @location = results.first
        format.html { redirect_to @location, notice: 'Location was successfully created.' }
        format.json { render :show, status: :created, location: @location }
      else
        format.html { render :new }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    sql = "UPDATE Location SET " \
    "address = '#{location_params[:address]}', " \
    "phoneNum = '#{location_params[:phoneNum]}' " \
    "WHERE locationId = #{params[:id]}"
    rows_updated = ActiveRecord::Base.connection.exec_update(sql)

    query = "SELECT * FROM Location WHERE locationId = #{params[:id]}"
    @location = Location.find_by_sql(query).first

    respond_to do |format|
      if rows_updated == 1
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    sql = "DELETE FROM Location WHERE locationId = #{params[:id]}"
    ActiveRecord::Base.connection.execute(sql)

    respond_to do |format|
      format.html { redirect_to locations_url, notice: 'Location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      query = "SELECT * FROM Location WHERE locationId = #{params[:id]}"
      @location = Location.find_by_sql(query).first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:address, :phoneNum)
    end
end
