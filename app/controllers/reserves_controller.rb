class ReservesController < ApplicationController
  before_action :set_reserf, only: [:show, :edit, :update, :destroy]

  # GET /reserves
  # GET /reserves.json
  def index
    @reserves = Reserf.all
  end

  # GET /reserves/1
  # GET /reserves/1.json
  def show
  end

  # GET /reserves/new
  def new
    @reserf = Reserf.new
  end

  # GET /reserves/1/edit
  def edit
  end

  # POST /reserves
  # POST /reserves.json
  def create
    @reserf = Reserf.new(reserf_params)

    respond_to do |format|
      if @reserf.save
        format.html { redirect_to @reserf, notice: 'Reserf was successfully created.' }
        format.json { render :show, status: :created, location: @reserf }
      else
        format.html { render :new }
        format.json { render json: @reserf.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reserves/1
  # PATCH/PUT /reserves/1.json
  def update
    respond_to do |format|
      if @reserf.update(reserf_params)
        format.html { redirect_to @reserf, notice: 'Reserf was successfully updated.' }
        format.json { render :show, status: :ok, location: @reserf }
      else
        format.html { render :edit }
        format.json { render json: @reserf.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reserves/1
  # DELETE /reserves/1.json
  def destroy
    @reserf.destroy
    respond_to do |format|
      format.html { redirect_to reserves_url, notice: 'Reserf was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reserf
      @reserf = Reserf.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reserf_params
      params.require(:reserf).permit(:Booking_id, :Location_id, :Room_id, :Guest_id)
    end
end
