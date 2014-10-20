class ArticlesController < ApplicationController
	respond_to :json

	def new
		@article = Article.new
	end
	
	def create
		@article = Article.new(article_params)
		if @article.save
			redirect_to root_path
		end
	end

	def index
		@articles = Article.includes(:authors)
	end

	def show
		@article = Article.find(params[:id])
		@authors = @article.authors
	end

	private
	
	def article_params
		params.require(:article).permit!
	end
end