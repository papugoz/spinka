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
		@categories = Category.all
	end

end