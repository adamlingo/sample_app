class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase)
  	# can also write as "if user&.authenticate. . "
  	if user && user.authenticate(params[:session][:password])
  		log_in user
  		redirect_to user
  	else
  		# 'flash.now' helps process and disappear message when a new request occurs,
  		# helping avoid the message still showing on a new render
	  	flash.now[:danger] = "Invalid email/password combination"
	    render 'new'
  	end
  end

  def destroy
  	log_out
  	redirect_to root_url
  end
end
