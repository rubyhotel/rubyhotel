class SessionsController < ApplicationController
  def new
  end

  def create

    #retrieve username from database
    username_query = "SELECT * FROM Guest WHERE username = '#{params[:session][:username]}'"
    guest_username = Guest.find_by_sql(username_query).first

    #retrieve password from database
    password_query = "SELECT * FROM Guest WHERE password = '#{params[:session][:password]}'"
    guest_password = Guest.find_by_sql(password_query).first

    if guest_username && guest_password
    puts "success"
      redirect_to "/guestportal/#{guest_username.id}"
    else
    puts 'Invalid username/password combination'
    render 'new'
    end
  end


  def destroy
  end
end
