class UsersController < ApplicationController

	def index
    @users = User.all
    if @users.empty? && signed_in?
      flash[:success] = flash[:success] if !flash[:success].blank?
      flash[:warning] = "There are currently no users in the database!"
      redirect_to new_user_path
    end
	end

  def new
  	@user = User.new
    redirect_to signin_path if !signed_in?
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  		flash[:success] = "User created successfully!"
  		redirect_to users_path
  	else
      flash.now[:warning] = "An error occurred"
  		render 'new'
  	end
  end

  def edit
    @user = User.find(params[:id])
    redirect_to signin_path if !signed_in?
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "User updated successfully!"
      redirect_to users_path
    else
      render 'edit'
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    flash[:success] = "User deleted successfully!"
    redirect_to users_path
  end

  private

  def user_params
  	params.require(:user).permit(:first, :last, :email)
  end

end
