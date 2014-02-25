class CommentsController < ApplicationController

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
		if Comment.find_by(id: params[:id])
			@comment = Comment.find_by(id: params[:id])
		else
			redirect_to root_url
		end
	end

	def update
		@comment = Comment.find_by(id: params[:id])
		if (@comment.created_at + 10 * 60 > Time.now || current_user.admin?) && @comment.update_attributes(comment_params)
			flash[:success] = "Komentarz zaktualizowany"
			redirect_to News.find_by(id: @comment.news.id)
		else
			if @comment.created_at + 10 * 60 < Time.now
				flash[:danger] = "Nie można edytować komentarzy do upływie 10 minut"
				redirect_to News.find_by(id: @comment.news.id)
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