class GuestportalController < ApplicationController
  def index

    query = "SELECT * FROM Guest WHERE guestId = #{params[:id]}"
    @guest = Guest.find_by_sql(query).first

    bookingquery = "SELECT * FROM Reserve r JOIN Booking b ON r.bookingId = b.bookingId JOIN Location l ON r.locationId = l.locationId WHERE r.guestId = #{params[:id]}"
    @bookings = ActiveRecord::Base.connection.exec_query(bookingquery).to_hash

  end

  def bookingedit
    @booking = Booking.find(params[:id])
  end

  def bookingcreate
    @guestId = Guest.find(params[:id]).guestId
    allLocationsQuery = "SELECT locationName FROM Location"
    @locations = Location.find_by_sql(allLocationsQuery)
  end

  def infoedit
    @guest = Guest.find(params[:id])
  end

  def submit
    h = eval("#{params[:inDate]}")
    inDate = Date.new(h['(1i)'].to_i, h['(2i)'].to_i, h['(3i)'].to_i).to_s
    h2 = eval("#{params[:outDate]}")
    outDate = Date.new(h2['(1i)'].to_i, h2['(2i)'].to_i, h2['(3i)'].to_i).to_s

    selectclause = []

    if params[:roomNum]
      selectclause << "r.roomNum"
    end
    if params[:amenities]
      selectclause << "r.amenities"
    end
    if params[:locationAddress]
      selectclause << "l.address"
    end
    if params[:locationName]
      selectclause << "l.locationName"
    end

    if selectclause.length < 1
      redirect_to "/guestportal/#{params[:guestId]}/bookingcreate", :alert => "Error: Must check atleast one show box"
    else
      counter = 0
      selectstring = ""
      selectclause.each do |element|
        if counter > 0
          selectstring << ", #{element}"
        else
          selectstring = "SELECT #{element}"
          counter += 1
        end
      end



    # Check that an unbooked room for the given dates exists
    roomSql = selectstring + " FROM Room r JOIN Location l ON r.locationId = l.locationId WHERE (r.locationId = #{params[:locationId]}) AND (r.roomNum NOT IN (SELECT res.roomNum FROM Reserve res JOIN Booking b ON res.bookingId = b.bookingId WHERE res.locationId = #{params[:locationId]} AND (('#{inDate}' >= b.inDate AND '#{inDate}'  < b.outDate) OR ('#{inDate}' <= b.inDate AND '#{outDate}' >= b.outDate) OR     ('#{inDate}' <= b.inDate AND '#{outDate}'  > b.inDate) OR     ('#{inDate}'  >= b.inDate AND '#{outDate}' <= b.outDate))))"
    roomNum = ActiveRecord::Base.connection.exec_query(roomSql)



    if roomNum.nil?
      puts 'No room available for the given dates and location'
      redirect_to "/guestportal/#{params[:guestId]}/bookingcreate", :notice => "No room available for the given dates and location"
    else
      puts 'Room(s) found for the given dates and location'

      @tableresult = hasharray_to_html(roomNum).to_s
      redirect_to "/guestportal/#{params[:guestId]}/bookingcreate", :notice => @tableresult
      roomNum = roomNum.first

    #   # Create a new booking
    #   cost = "#{params[:numOfGuests]}".to_f * 100
    #   bookingSql = "INSERT INTO Booking (cost, inDate, outDate, numOfGuests) " \
    # "VALUES (#{cost}, '#{inDate}', " \
    # "'#{outDate}', #{params[:numOfGuests]})"
    #   ActiveRecord::Base.connection.exec_insert(bookingSql)
    #
    #   # Get the booking id of the last inserted booking
    #   key_query = 'SELECT LAST_INSERT_ID()'
    #   bookingId = ActiveRecord::Base.connection.execute(key_query).first.first
    #
    #   # Create a new reservation
    #   reserveSql = "INSERT INTO Reserve (bookingId, roomNum, locationId, guestId) " \
    # "VALUES (#{bookingId}, #{roomNum}, #{params[:locationId]}, #{params[:guestId]})"
    #   ActiveRecord::Base.connection.exec_insert(reserveSql)
    #
    #   redirect_to "/guestportal/#{params[:guestId]}"
    end
    end
  end


  require 'builder'

  def hasharray_to_html( hashArray )
    # collect all hash keys, even if they don't appear in each hash:
    headers = hashArray.inject([]){|a,x| a |= x.keys ; a}  # use array union to find all unique headers/keys

    html = Builder::XmlMarkup.new(:indent => 2)
    html.table {
      html.tr { headers.each{|h| html.th(h)} }
      hashArray.each do |row|
        html.tr { row.values.each { |value| html.td(value) }}
      end
    }
    return html
  end

  def deletebooking
    sql = "DELETE FROM Booking WHERE bookingId = #{params[:bookingId]}"
    ActiveRecord::Base.connection.execute(sql)

    respond_to do |format|
      format.html { redirect_to "/guestportal/#{params[:guestId]}", notice: 'Booking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
end