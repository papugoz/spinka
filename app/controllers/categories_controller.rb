class CategoriesController < ApplicationController
	before_action :signed_in_user, only: [:index, :new, :create, :edit, :update, :destroy]
before_action :admin_user, only: [:index, :new, :create, :edit, :update, :destroy]

	def show
		@category = Category.find_by_id(params[:id])
		@topics = @category.topics.paginate(page: params[:page])
	end

end