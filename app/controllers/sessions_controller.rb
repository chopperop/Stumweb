class SessionsController < ApplicationController

  def new
    @title = "Sign in"
  end
  
  def create
    user = User.authenticate(params[:sessions][:username],
                             params[:sessions][:password]) unless params[:sessions].nil?
    if user.nil?
      flash.now[:error] = "Invalid username/password combination."
      @title = "Sign in"
      render 'new'
    else
      sign_in user
      redirect_to root_path
      #redirect_back_or user
    end
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end
end
