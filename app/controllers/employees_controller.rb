class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :destroy]

  # GET /employees
  # GET /employees.json
  def index
    query = 'SELECT * FROM Employee'
    @employees = Employee.find_by_sql(query)
  end

  # GET /employees/1
  # GET /employees/1.json
  def show
    query = "SELECT * FROM Employee WHERE employeeId = #{params[:id]}"
    @employee = Employee.find_by_sql(query).first
  end

  # GET /employees/new
  def new
    @employee = Employee.new
  end

  # GET /employees/1/edit
  def edit
  end

  # POST /employees
  # POST /employees.json
  def create
    sql = "INSERT INTO Employee (name, phoneNum, position, hourlyRate, startDate, locationId) " \
    "VALUES ('#{employee_params[:name]}', '#{employee_params[:phoneNum]}', '#{employee_params[:position]}'," \
    "#{employee_params[:hourlyRate]}, '#{employee_params[:startDate]}', #{employee_params[:locationId]})"
    ActiveRecord::Base.connection.exec_insert(sql)

    key_query = 'SELECT LAST_INSERT_ID()'
    pkey = ActiveRecord::Base.connection.execute(key_query).first.first

    query = "SELECT * FROM Employee WHERE employeeId = #{pkey}"
    results = Employee.find_by_sql(query)

    respond_to do |format|
      if results.length == 1
        @employee = results.first
        format.html { redirect_to @employee, notice: 'Employee was successfully created.' }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1
  # PATCH/PUT /employees/1.json
  def update
    sql = "UPDATE Employee SET " \
    "name = '#{employee_params[:name]}', " \
    "phoneNum = '#{employee_params[:phoneNum]}', " \
    "position = '#{employee_params[:position]}', " \
    "hourlyRate = #{employee_params[:hourlyRate]}, " \
    "startDate = '#{employee_params[:startDate]}', " \
    "locationId = #{employee_params[:locationId]} " \
    "WHERE employeeId = #{params[:id]}"
    rows_updated = ActiveRecord::Base.connection.exec_update(sql)

    query = "SELECT * FROM Location WHERE locationId = #{params[:id]}"
    @location = Location.find_by_sql(query).first

    respond_to do |format|
      if rows_updated == 1
        format.html { redirect_to @employee, notice: 'Employee was successfully updated.' }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1
  # DELETE /employees/1.json
  def destroy
    sql = "DELETE FROM Employee WHERE employeeId = #{params[:id]}"
    ActiveRecord::Base.connection.execute(sql)

    respond_to do |format|
      format.html { redirect_to employees_url, notice: 'Employee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      query = "SELECT * FROM Employee WHERE employeeId = #{params[:id]}"
      @employee = Employee.find_by_sql(query).first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      params.require(:employee).permit(:name, :phoneNum, :position, :hourlyRate, :startDate, :Location_id)
    end
end
