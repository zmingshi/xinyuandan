module SessionsHelper
  
  def sign_in(user)
    self.current_user = user
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= user_from_id
  end

  def signed_in?
	!current_user.nil?
  end

  def current_user?(user)
    user == current_user
  end

  def sign_out
	self.current_user = nil
  end

  private
    def user_from_id
	  User.find_by(id: session[:user_id])
	end

end
