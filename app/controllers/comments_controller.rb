class CommentsController < ApplicationController
	before_action :signed_in_user, only: [:create, :edit, :update, :destroy]
	before_action :admin_user, only: [:destroy]

	def create
		@comment = News.find_by(id: comment_params[:news_id]).comments.build(comment_params)
		if @comment.save
			flash[:success] = "Dodano komentarz"
			redirect_to :back
		else
			flash[:danger] = "Nie dodano komentarza"
			redirect_to :back
		end
	end

	def edit
		if Comment.find_by_id(params[:id]) && (administrator || Comment.find_by_id(params[:id]).created_at + 10 > Time.now)
			@comment = Comment.find_by_id(params[:id])
		else
			if Comment.find_by_id(params[:id])
				flash[:danger] = "Nie można edytować komentarzy do upływie 10 minut"
				redirect_to news_path(Comment.find_by_id(params[:id]).news)
			else
				redirect_to root_url
			end
		end
	end

	def update
		@comment = Comment.find_by_id(params[:id])
		if (@comment.created_at + 10 * 60 > Time.now || current_user.admin?) && @comment.update_attributes(comment_params)
			flash[:success] = "Komentarz zaktualizowany"
			redirect_to News.find_by(id: @comment.news.id)
		else
			if @comment.created_at + 10 * 60 < Time.now
				flash[:danger] = "Nie można edytować komentarzy do upływie 10 minut"
				redirect_to News.find_by_id(@comment.news.id)
			else
				render 'edit'
			end
		end
	end

	def destroy
		Comment.find(params[:id]).destroy
		flash[:success] = "Komentarz usunięty."
		redirect_to request.referer + '#news-comments'
	end

	private

	def comment_params
		params.require(:comment).permit(:news_id, :user_id, :content)
	end
end