class UsersController < ApplicationController
	before_action :signed_in_user, only: [:edit, :update, :index]
	before_action :correct_user, only: [:edit, :update]
	before_action :admin_user, only: [:index]
	before_action :not_signed_in?, only: [:new, :create]

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			sign_in @user
			flash[:success] = "Pomyslnie zarejestrowany"
			redirect_to @user
		else
			render 'new'
		end
	end

	def show
		@user = User.find_by(id: params[:id])
	end

	def index
		@users = User.paginate(page: params[:page])
	end

	def edit
		@user = User.find_by(id: params[:id])
	end

	def update
		@user = User.find_by(id: params[:id])
		user_params.delete(["password", "password_confirmation"])
		if @user.update_attributes(user_params)
			flash[:success] = "Profil zaktualizowany"
			redirect_to @user
		else
			render 'edit'
		end
	end


	def destroy
		User.find(params[:id]).destroy
		flash[:success] = "użytkonik usunięty."
		redirect_to users_url
	end

	private

	def user_params
		params.require(:user).permit(:first_name, :last_name, :username, :email, :password, :password_confirmation)
	end

	def not_signed_in?
		redirect_to root_url, notice: "Jestes już zalogowany" unless current_user.nil?
	end
end
