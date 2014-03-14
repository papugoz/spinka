class TopicsController < ApplicationController
before_action :signed_in_user, only: [:new, :create, :edit, :update, :destroy]
before_action :admin_user, only: [:destroy]
before_action only: [:edit, :update] do
	owner_or_admin(Topic.find_by_id(params[:id]))
	end

	def new
		@topic = Topic.new
		@category = Category.find_by(params[:category_id])
	end

	def create
		@topic = current_user.topics.build(topic_params)
		if @topic.save
			redirect_to @topic
		else
			render 'new'
		end
	end

	def show
		@topic = Topic.find_by_id(params[:id])
		@posts = @topic.posts
	end

	def edit
		if Topic.find_by(id: params[:id])
			@topic = Topic.find_by(id: params[:id])
		else
			redirect_to root_url
		end
	end

	def update
		@topic = Topic.find_by(id: params[:id])

		if @topic.update_attributes(topic_params)
			flash[:success] = "Temat zaktualizowany"
			redirect_to @topic
		else
			render 'edit'
		end
	end

	def destroy
		Topic.find(params[:id]).destroy
		flash[:success] = "Temat usunięty."
		redirect_to forum_url
	end

	private

	def topic_params
		params.require(:topic).permit(:title, :content, :category_id)
	end
end
