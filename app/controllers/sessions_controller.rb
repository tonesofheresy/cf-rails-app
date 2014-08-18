class SessionsController < ApplicationController
  
  def new
  	
  end

  def create
    user = AdminUser.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
			sign_in user
			redirect_to root_path
    else
      flash.now[:warning] = 'Invalid email/password'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

end
