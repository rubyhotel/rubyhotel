class ManagerPortalController < ApplicationController
  # GET /managerportal/:id
  def index
    manager_query = "SELECT e.name, e.phoneNum, e.position, e.hourlyRate, e.startDate, l.locationId, l.address " \
                    "FROM Employee e " \
                    "LEFT JOIN Location l ON e.locationId = l.locationId " \
                    "WHERE e.employeeId = #{params[:id]}"
    @employee = ActiveRecord::Base.connection.exec_query(manager_query).to_hash.first

    employees_query = 'SELECT * FROM Employee LEFT JOIN Location ON Employee.locationId = Location.locationId'
    @employees = Employee.find_by_sql(employees_query)

    vip_query = "SELECT * FROM Guest g WHERE NOT EXISTS " \
				        "(SELECT l.locationId FROM Location l WHERE l.locationId NOT IN " \
                "(SELECT r.locationId FROM Reserve r WHERE r.guestId = g.guestId))"
    @vips = Guest.find_by_sql(vip_query)

  end

  def search_aggregate
    case params[:aggregator]
      when 'max'
        agg_query = 'SELECT b.cost, b.numOfGuests FROM Booking b ' \
                    'WHERE b.cost=(SELECT MAX(b2.cost) FROM Booking b2)'
        agg = Booking.find_by_sql(agg_query)
        render json: agg
      when 'min'
        agg_query = 'SELECT b.cost, b.numOfGuests FROM Booking b ' \
                    'WHERE b.cost=(SELECT MIN(b2.cost) FROM Booking b2)'
        agg = Booking.find_by_sql(agg_query)
        render json: agg
      when 'count'
        agg_query = 'SELECT COUNT(*) AS count FROM Booking b'
        agg = Booking.find_by_sql(agg_query)
        render json: agg
      when 'avg'
        agg_query = 'SELECT AVG(b.cost) AS cost, AVG(b.numOfGuests) AS numOfGuests FROM Booking b'
        agg = Booking.find_by_sql(agg_query)
        render json: agg
      when 'sum'
        agg_query = 'SELECT SUM(b.cost) AS cost, SUM(b.numOfGuests) AS numOfGuests FROM Booking b'
        agg = Booking.find_by_sql(agg_query)
        render json: agg
      else
        render :nothing => true, :status => 204
    end
  end

  def group_by_search_aggregate
    case params[:aggregator]
      when 'max'
        agg_query = 'SELECT * FROM (' \
                    'SELECT l.address AS locationAddress, AVG(e.hourlyRate) AS avgHourlyRate ' \
                    'FROM Employee e LEFT JOIN Location l ON e.locationId = l.locationId ' \
                    'GROUP BY l.locationId) AS locationGroupsTable ' \
                    'WHERE avgHourlyRate=(' \
                    'SELECT MAX(avgHourlyRate) FROM (SELECT AVG(e.hourlyRate) AS avgHourlyRate ' \
                    'FROM Employee e LEFT JOIN Location l ON e.locationId = l.locationId ' \
                    'GROUP BY l.locationId) AS locationGroupsTable)'
        agg = Location.find_by_sql(agg_query)
        render json: agg
      when 'min'
        agg_query = 'SELECT * FROM (' \
                    'SELECT l.address AS locationAddress, AVG(e.hourlyRate) AS avgHourlyRate ' \
                    'FROM Employee e LEFT JOIN Location l ON e.locationId = l.locationId ' \
                    'GROUP BY l.locationId) AS locationGroupsTable ' \
                    'WHERE avgHourlyRate=(' \
                    'SELECT MIN(avgHourlyRate) FROM (SELECT AVG(e.hourlyRate) AS avgHourlyRate ' \
                    'FROM Employee e LEFT JOIN Location l ON e.locationId = l.locationId ' \
                    'GROUP BY l.locationId) AS locationGroupsTable)'
        agg = Location.find_by_sql(agg_query)
        render json: agg
      else
        render :nothing => true, :status => 204
    end
  end
end
