class PostsController < ApplicationController
	before_action :signed_in_user, only: [:create, :edit, :update, :destroy]
	before_action :admin_user, only: [:destroy]

	def create
		@post = Topic.find_by(id: post_params[:topic_id]).posts.build(post_params)
		if @post.save
			flash[:success] = "Dodano odpowiedź"
			redirect_to :back
		else
			flash[:danger] = "Nie dodano odpowiedzi"
			redirect_to :back
		end
	end

	def edit
		if Post.find_by(id: params[:id]) && (administrator || Post.find_by(id: params[:id]).created_at + 10 > Time.now)
			@post = Post.find_by(id: params[:id])
		else
			if Post.find_by(id: params[:id])
				flash[:danger] = "Nie można edytować odpowiedzi do upływie 10 minut"
				redirect_to topic_path(Post.find_by(id: params[:id]).topic)
			else
				redirect_to root_url
			end
		end
	end

	def update
		@post = Post.find_by(id: params[:id])
		if (@post.created_at + 10 * 60 > Time.now || current_user.admin?) && @post.update_attributes(post_params)
			flash[:success] = "Odpowiedź zaktualizowana"
			redirect_to Topic.find_by(id: @post.topic.id)
		else
			if @post.created_at + 10 * 60 < Time.now
				flash[:danger] = "Nie można edytować odpowiedzi do upływie 10 minut"
				redirect_to Topic.find_by(id: @post.topic.id)
			else
				render 'edit'
			end
		end
	end

	def destroy
		Post.find(params[:id]).destroy
		flash[:success] = "Odpowiedź usunięta."
		redirect_to request.referer + '#topic-posts'
	end

	private

	def post_params
		params.require(:post).permit(:topic_id, :user_id, :content)
	end
end
