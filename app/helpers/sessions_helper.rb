module SessionsHelper
	# logs in user and sets id
	# session[:user_id] makes use of rails session method that deletes cookies
	# once the browser is closed
	def log_in(user)
		session[:user_id] = user.id
	end

	#returns current logged in user if there is one
	def current_user
		@current_user ||= User.find_by(id: session[:user_id])
	end

	# return true if user is logged in
	def logged_in?
		!current_user.nil?
	end

	# log_out deletes user session and sets current_user to nil
	def log_out
		session.delete(:user_id)
		@current_user = nil
	end
end
