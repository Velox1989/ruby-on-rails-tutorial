class SessionsController < ApplicationController
  def new
  end

  def create

    # authenticate the user
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])

    # log the user in using log_in method defined in helpers/sessions_helper
    log_in user

    # redirect to the user's show page
    # rails automatically converts this to the route for the user’s profile
    # page: user_url(user)
    redirect_to user

    else
      # he issue is that the contents of the flash persist for one request,
      # but unlike a redirect, re-rendering
      # a template with render doesn’t count as a request. The result is
      # that the flash message persists one request longer than we want.
      # For example, if we submit invalid login information and then click on
      # the Home page, the flash gets displayed a second time

      # flash[:danger] = 'Invalid email/password combination'

      # we use this instead
      flash.now[:danger] = 'Invalid email/password combination'

      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
  
end
