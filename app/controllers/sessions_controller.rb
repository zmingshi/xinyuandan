class SessionsController < ApplicationController
  #skip_before_action :authorize
  #get
  def new
  end
  
  #post
  def create
    user = User.find_by(name: params[:name])
	respond_to do |format|
	  if user and user.authenticate(params[:password])
	    session[:user_id] = user.id
	    sign_in user
	    @wish_items = user.wish_items
	    format.html { render json: { :wish_items => @wish_items, :user => user } }
	    format.json { render json: { :wish_items => @wish_items, :user => user } }
	  else
	    format.html { render json: { :error => 'SignInFailed' } }
	    format.json { render json: { :error => 'SignInFailed' } }
	    # redirect_to user_url(:id => session[:user_id])
	    # redirect_to user_url(user)
		# redirect_to login_url, alert: "Invalid user/password combination"
	  end
	end
end
  
  #delete
  def destroy
    sign_out
    session[:user_id] = nil
	redirect_to login_url, notice: "Logged out"
  end
end
