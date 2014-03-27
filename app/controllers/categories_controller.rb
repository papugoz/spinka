class CategoriesController < ApplicationController
	before_action :signed_in_user, only: [:index, :new, :create, :edit, :update, :destroy]
	before_action :admin_user, only: [:index, :new, :create, :edit, :update, :destroy]

	def show
		@category = Category.find_by_id(params[:id])
		@topics = @category.topics.paginate(page: params[:page])
	end

	def new
		@category = Category.new
	end

	def create
		@category = Category.create(category_params)
		if @category.save
			redirect_to forum_kategorie_path
		else
			render 'new'
		end
	end

	def edit

	end

	def update

	end

	def destroy
		Category.find_by_id(params[:id]).delete
		redirect_to :back
	end

	def index
		@categories = Category.all
	end

	private

	def category_params
		params.require(:category).permit(:title)
	end

end