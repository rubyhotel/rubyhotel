class FacilitiesController < ApplicationController
  before_action :set_facility, only: [:show, :edit, :update, :destroy]

  # GET /facilities
  # GET /facilities.json
  def index
    query = 'SELECT * FROM Facility'
    @facilities = Facility.find_by_sql(query)
  end

  # GET /facilities/1
  # GET /facilities/1.json
  def show
    query = "SELECT * FROM Facility WHERE facilityId = #{params[:id]}"
    @facility = Facility.find_by_sql(query).first
  end

  # GET /facilities/new
  def new
    @facility = Facility.new
  end

  # GET /facilities/1/edit
  def edit
  end

  # POST /facilities
  # POST /facilities.json
  def create
    # take parameter as quote to escape apostrophes
    qname = ActiveRecord::Base.connection.quote(facility_params[:name])

    sql = "INSERT INTO Facility (name, facType, pricing, locationId) " \
    "VALUES (#{qname}, '#{facility_params[:factype]}', " \
    "#{facility_params[:pricing]}, #{facility_params[:locationId]})"
    ActiveRecord::Base.connection.exec_insert(sql)

    key_query = 'SELECT LAST_INSERT_ID()'
    pkey = ActiveRecord::Base.connection.execute(key_query).first.first

    query = "SELECT * FROM Facility WHERE facilityId = #{pkey}"
    results = Facility.find_by_sql(query)

    respond_to do |format|
      if results.length == 1
        @facility = results.first
        format.html { redirect_to @facility, notice: 'Facility was successfully created.' }
        format.json { render :show, status: :created, location: @facility }
      else
        format.html { render :new }
        format.json { render json: @facility.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /facilities/1
  # PATCH/PUT /facilities/1.json
  def update
    # take parameter as quote to escape apostrophes
    qname = ActiveRecord::Base.connection.quote(facility_params[:name])

    sql = "UPDATE Facility SET " \
    "name = #{qname}, " \
    "facType = '#{facility_params[:factype]}', " \
    "pricing = '#{facility_params[:pricing]}', " \
    "locationId = '#{facility_params[:locationId]}' " \
    "WHERE facilityId = #{params[:id]}"
    rows_updated = ActiveRecord::Base.connection.exec_update(sql)

    query = "SELECT * FROM Facility WHERE facilityId = #{params[:id]}"
    @facility = Facility.find_by_sql(query).first

    respond_to do |format|
      if rows_updated == 1
        format.html { redirect_to @facility, notice: 'Facility was successfully updated.' }
        format.json { render :show, status: :ok, location: @facility }
      else
        format.html { render :edit }
        format.json { render json: @facility.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /facilities/1
  # DELETE /facilities/1.json
  def destroy
    sql = "DELETE FROM Facility WHERE facilityId = #{params[:id]}"
    ActiveRecord::Base.connection.execute(sql)

    respond_to do |format|
      format.html { redirect_to facilities_url, notice: 'Facility was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_facility
      query = "SELECT * FROM Facility WHERE facilityId = #{params[:id]}"
      @facility = Facility.find_by_sql(query).first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def facility_params
      params.require(:facility).permit(:name, :factype, :pricing, :locationId)
    end
end