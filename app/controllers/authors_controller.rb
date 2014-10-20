class AuthorsController < ApplicationController
	def new
		@articles = Article.all
		@author = Author.new
	end
	
	def create
		@articles = Article.all
		@author = Author.new(author_params)
		if @author.save
			redirect_to root_path
		end
	end

	def index
		@author = Author.all
	end

	private 
	def author_params
		params.require(:author).permit!
	end
end