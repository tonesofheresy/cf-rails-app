class UsersController < ApplicationController

	def index
    @users = User.all
    redirect_to action: 'new' if @users.empty?
	end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  		flash[:success] = "User created successfully!"
  		redirect_to action: 'index'
  	else
  		render 'new'
  	end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "User updated successfully!"
      redirect_to action: 'index'
    else
      render 'edit'
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    flash[:success] = "User deleted successfully!"
    redirect_to action: 'index'
  end

  private

  def user_params
  	params.require(:user).permit(:first, :last, :email)
  end

end
