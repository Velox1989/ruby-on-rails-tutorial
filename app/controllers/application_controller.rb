class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # including the Sessions helper module into the Application controller
  include SessionsHelper
  
end
