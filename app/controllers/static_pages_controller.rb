class StaticPagesController < ApplicationController

	def home
		@news = News.first(5)
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