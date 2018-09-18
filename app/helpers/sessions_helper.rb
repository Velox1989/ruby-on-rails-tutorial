module SessionsHelper

  # logs in the given user
  # we use login funcionality in two files (create functions)
  # 1 sessions_controller
  # 2 user_controllers

  def log_in(user)
    session[:user_id] = user.id
  end

  # returns the current logged-in user (if any).
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
      # @current_user = @current_user || User.find_by(id: session[:user_id])
    end
  end

  # @foo = @foo || "bar"    ->     @foo ||= "bar"

  # common Ruby pattern is assigning to a variable if it’s nil but otherwise
  # leaving it alone:

  #  >> @foo
  #  => nil
  #  >> @foo = @foo || "bar"
  #  => "bar"
  #  >> @foo = @foo || "baz"
  #  => "bar"

  # returns true if the user is logged in, false otherwise
  def logged_in?
    !current_user.nil?
  end

  # logs out the current user
  # logging out involves undoing the effects of the log_in method,
  # which involves deleting the user id from the session
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

end
