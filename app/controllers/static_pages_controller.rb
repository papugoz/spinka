class StaticPagesController < ApplicationController

	def home
		@news = News.first(5)
		@side_news = News.offset(5).first(10)
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