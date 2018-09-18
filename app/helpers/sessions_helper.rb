module SessionsHelper

  # logs in the given user
  # we use login funcionality in two files (create functions)
  # 1 sessions_controller
  # 2 user_controllers

  def log_in(user)
    session[:user_id] = user.id
  end

  # remembers a user in a persistent session
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # returns the current logged-in user (if any).
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
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

  # forgets a persistent session
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # logs out the current user
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

end
