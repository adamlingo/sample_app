module SessionsHelper
	# logs in user and sets id
	# session[:user_id] makes use of rails session method that deletes cookies
	# once the browser is closed
	def log_in(user)
		session[:user_id] = user.id
	end

	# remember a user in persistent session
	def remember(user)
		user.remember
		cookies.permanent.signed[:user_id] = user.id
		cookies.permanent[:remember_token] = user.remember_token
	end

	#returns current logged in user if there is one
	def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # return true if given user is current_user
  def current_user?(user)
  	user && user == current_user
  end

	# return true if user is logged in
	def logged_in?
		!current_user.nil?
	end
	
	# Forget a persistent session
	def forget(user)
		user.forget
		cookies.delete(:user_id)
		cookies.delete(:remember_token)
	end

	# log_out deletes user session and sets current_user to nil
	def log_out
		forget(current_user)
		session.delete(:user_id)
		@current_user = nil
	end

	# Redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
