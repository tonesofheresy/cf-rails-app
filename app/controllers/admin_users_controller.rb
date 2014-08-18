class AdminUsersController < ApplicationController

  def new
  	@user = AdminUser.new
    redirect_to root_path if signed_in?
  end

  def create
  	@user = AdminUser.new(user_params)
  	if @user.save
      sign_in @user
  		flash[:success] = "Thank you for signing up!"
  		redirect_to root_path
  	else
      flash.now[:warning] = "An error occurred"
  		render 'new'
  	end
  end

  private

  def user_params
  	params.require(:admin_user).permit(:name, :email, :password, :password_confirmation)
  end
end
