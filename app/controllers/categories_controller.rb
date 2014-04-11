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
		@category = Category.find_by(id: params[:id])
	end

	def update
		if params[:category][:change_type] == "position"
			@category = Category.find_by(id: params[:category][:id])
			if params[:category][:dir] == "up"
				@category.slide_up!
			elsif params[:category][:dir] == "down"
				@category.slide_down!
			end
			redirect_to :back
		elsif params[:category][:change_type] == "title"
			@category = Category.find_by(id: params[:id])
			@category.update_attributes(category_params)
			if @category.save
				flash[:success] = "Nazwa zaktualizowana"
				redirect_to @category
			else
				render 'edit'
			end
		end
	end

	def destroy
		Category.find_by_id(params[:id]).delete
		redirect_to :back
	end

	def index
		@categories = Category.all.order(:custom_index)
	end

	private

	def category_params
		params.require(:category).permit(:title)
	end

end