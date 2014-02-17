class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			flash[:success] = "Pomyslnie zarejestrowany"
			redirect_to root_path
		else
			render 'new'
		end
	end

	def show
		@user = User.find_by(id: params[:id])
	end

	def edit
		@user = User.find_by(id: params[:id])
	end

	def update
		@user = User.find_by(id: params[:id])
		if @user.update_attributes(user_params)
			flash[:success] = "Profil zaktualizowany"
			redirect_to @user
		else
			render 'edit'
		end
	end

	def delete

	end

	private

	def user_params
		params.require(:user).permit(:first_name, :last_name, :username, :email, :password, :password_confirmation)
	end
end
