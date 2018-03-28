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
        puts "success"
        redirect_to "/guests/#{guest.id}"
      end
    elsif user_type == 'employee'
      #retrieve username from database
      query = "SELECT * FROM Employee WHERE username = '#{params[:username]}'"
      employee = Employee.find_by_sql(query).first

      if !employee || employee.password != params[:password]
        puts 'Invalid username and/or password combination'
        redirect_to login_path :user => user_type, :error => true
      else
        puts "success"
        redirect_to "/employees/#{employee.id}"
      end
    end
  end

  def destroy
  end
end
