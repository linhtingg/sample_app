class UsersController < ApplicationController
  # before running edit/update, run the action
  before_action :find_user, only: %i[show edit update correct_user]
  before_action :logged_in_user, only: %i[edit update index destroy]
  before_action :correct_user, only: %i[edit update]
  before_action :admin_user, only: %i[destroy]
  
  def index
		# @users = User.paginate(page: params[:page])
    @pagy, @users = pagy(User.all, items: 15) 
	end
  
  def new
    @user = User.new
  end

  def show; end

  def create
    # @user = User.new(params[:user]) 
    # but since we need to specify which input parameters are permitted or required 
    @user = User.new(user_params)
    if @user.save
      reset_session
      log_in @user
      
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
      else
      render :new, status: :unprocessable_entity
    end
  end

  def edit;  end

  def update
    if @user.update(user_params)
      # Handle a successful update
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      # Handle unsuccessful update
      render 'edit', status: :unprocessable_entity
    end
  end   

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_path, status: :see_other
  end

  private
    # raising an error if the :user attribute is missing
    # returns a version of the params hash with only the permitted attributes
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # Before filters, confirms a logged-in user.
    # Redirects to the login form if the user is not logged in.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url, status: :see_other
      end
    end

    # Confirms the correct user.
		def correct_user
			redirect_to(root_url, status: :see_other) unless @user == current_user      
		end

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url, status: :see_other) unless current_user.admin?
    end

    def find_user
      @user=User.find(params[:id])
    end
end
