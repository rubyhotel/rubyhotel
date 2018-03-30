class HomeController < ApplicationController
  def index
  end

  def log_in
    @user = params[:user]
    @error = params[:error]
  end

  def submit
    user_type = params[:user]
    if user_type == 'guest'
      #retrieve username from database
      query = "SELECT * FROM Guest WHERE username = '#{params[:username]}'"
      guest = Guest.find_by_sql(query).first

      if !guest || guest.password != params[:password]
        puts 'Invalid username and/or password combination'
        redirect_to login_path :user => user_type, :error => true
      else
        puts 'success'
        redirect_to guest_portal_path(guest)
      end
    elsif user_type == 'employee'
      #retrieve username from database
      query = "SELECT * FROM Employee WHERE username = '#{params[:username]}'"
      employee = Employee.find_by_sql(query).first

      if !employee || employee.password != params[:password]
        puts 'Invalid username and/or password combination'
        redirect_to login_path :user => user_type, :error => true
      else
        puts 'success'
        case employee.position
          when 'manager'
            puts 'manager position'
            # change redirect to manager specific portal
            redirect_to manager_portal_path(employee)
          else
            puts 'regular staff'
            redirect_to "/employeeportal/#{employee.id}"
        end
      end
    end
  end

  def destroy
  end
end
