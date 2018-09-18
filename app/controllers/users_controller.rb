class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save

      # log in new users automatically as part of the signup process
      log_in @user
      
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    # params[:id] is the string "1",
    # but find is smart enough to convert this to an integer.
    @user = User.find(params[:id])

    # byebug
    # debugger

    # whenever you’re confused about something in a Rails application,
    # it’s a good practice to put debugger close to the code you think
    # might be causing the trouble.
  end

  private

  # permit user's params (name, email, password, password confirmation...
  # but no others
  # this code returns a version of the params hash with only the permitted
  # attributes (while raising an error if the :user attribute is missing).
  def user_params
    params.require(:user).permit(:name, :email, :password,
      :password_confirmation)
  end

end
