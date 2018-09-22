class UsersController < ApplicationController

  # Before filters use the before_action command to arrange for a particular
  # method to be called before the given actions.4 To require users to be
  # logged in, we define a logged_in_user method and invoke it using
  # before_action :logged_in_user
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.paginate(page: params[:page])
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

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # successful update
      flash[:success] = "Profile updated"
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
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

  # confirms a logged-in user
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  # confirms the correct user
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
  
end
