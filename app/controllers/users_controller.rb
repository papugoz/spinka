class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			redirect_to root_path
		else
			render 'new'
		end
	end

	def show

	end

	def edit

	end

	def delete

	end

	private 

	def user_params
		params.require(:user).permit(:username, :email, :password, :password_confirmation)
	end
end
