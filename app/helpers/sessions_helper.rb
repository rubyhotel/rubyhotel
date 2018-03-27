module SessionsHelper

  # Logs in the given user.
  def log_in(guest)
    session[:user_id] = guest.guestId
  end

end
