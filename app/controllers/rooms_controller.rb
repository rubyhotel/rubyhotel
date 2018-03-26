class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]

  # GET /rooms
  # GET /rooms.json
  def index
    query = 'SELECT * FROM Room'
    @rooms = Room.find_by_sql(query)
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
    query = "SELECT * FROM Room WHERE roomId = #{params[:id]}"
    @room = Room.find_by_sql(query).first
  end

  # GET /rooms/new
  def new
    @room = Room.new
  end

  # GET /rooms/1/edit
  def edit
  end

  # POST /rooms
  # POST /rooms.json
  def create
    sql = "INSERT INTO Room (roomNum, amenities, isVacant, isClean, locationId) " \
    "VALUES (#{room_params[:roomNum]}, '#{room_params[:amenities]}', #{room_params[:isVacant]}, " \
    "#{room_params[:isClean]}, #{room_params[:locationId]})"
    ActiveRecord::Base.connection.exec_insert(sql)

    key_query = 'SELECT LAST_INSERT_ID()'
    pkey = ActiveRecord::Base.connection.execute(key_query).first.first

    query = "SELECT * FROM Room WHERE roomId = #{pkey}"
    results = Room.find_by_sql(query)

    respond_to do |format|
      if results.length == 1
        @room = results.first
        format.html { redirect_to @room, notice: 'Room was successfully created.' }
        format.json { render :show, status: :created, location: @room }
      else
        format.html { render :new }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rooms/1
  # PATCH/PUT /rooms/1.json
  def update
    sql = "UPDATE Room SET " \
    "roomNum = #{room_params[:roomNum]}, " \
    "amenities = '#{room_params[:amenities]}', " \
    "isVacant = #{room_params[:isVacant]}, " \
    "isClean = #{room_params[:isClean]}, " \
    "locationId = #{room_params[:locationId]} " \
    "WHERE roomId = #{params[:id]}"
    rows_updated = ActiveRecord::Base.connection.exec_update(sql)

    query = "SELECT * FROM Room WHERE roomId = #{params[:id]}"
    @room = Room.find_by_sql(query).first

    respond_to do |format|
      if rows_updated == 1
        format.html { redirect_to @room, notice: 'Room was successfully updated.' }
        format.json { render :show, status: :ok, location: @room }
      else
        format.html { render :edit }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    sql = "DELETE FROM Room WHERE roomId = #{params[:id]}"
    ActiveRecord::Base.connection.execute(sql)
    respond_to do |format|
      format.html { redirect_to rooms_url, notice: 'Room was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      query = "SELECT * FROM Room WHERE roomId = #{params[:id]}"
      @room = Room.find_by_sql(query).first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def room_params
      params.require(:room).permit(:roomNum, :amenities, :isVacant, :isClean, :Location_id)
    end
end
