class SessionsController < ApplicationController
  #skip_before_action :authorize
  #get
  def new
  end
  
  #post
  def create
    user = User.find_by(name: params[:name])
	if user and user.authenticate(params[:password])
	  session[:user_id] = user.id
	  #sign_in user
	  redirect_to user_url(:id => session[:user_id])
	  #redirect_to user_url(user)
	else 
	  redirect_to login_url, alert: "Invalid user/password combination"
	end
  end
  
  #delete
  def destroy
    session[:user_id] = nil
	redirect_to login_url, notice: "Logged out"
  end
end
