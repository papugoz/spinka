class StaticPagesController < ApplicationController

	def home
		@news = News.order('created_at DESC').first(5)
		@side_news = News.order('created_at DESC').offset(5).first(10)
	end

	def onas

	end

	def pomoc

	end

	def kontakt

	end

	def forum
		if current_user && current_user.forum_layouts.any?
			@categories = Category.joins(:forum_layouts).where("user_id = ?", current_user.id).order("forum_layouts.user_custom_index ASC")
		else
			@categories = Category.all.order(:custom_index)
		end
	end

end