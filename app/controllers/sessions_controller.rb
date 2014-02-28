class SessionsController < ApplicationController
	before_action :store_referrer, only: [:new]
	before_action :not_signed_in_user, only: [:new, :create]

	def new

	end

	def create
		user = User.find_by(username: params[:username])
		if user && user.authenticate(params[:password])
			sign_in user
			redirect_back_or user
			flash[:success] = 'Zalogowano pomyslnie'
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
