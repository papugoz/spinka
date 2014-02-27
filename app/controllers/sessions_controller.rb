class SessionsController < ApplicationController

	def new

	end

	def create
		user = User.find_by(username: params[:username])
		if user && user.authenticate(params[:password])
			sign_in user
			flash[:success] = 'Zalogowano pomyslnie'
			redirect_back_or user
		else
			flash.now[:danger] = 'Nieprawidłowe dane logowania'
			render 'new'
		end
	end

	def destroy
		sign_out
		redirect_to :back
	end

end
