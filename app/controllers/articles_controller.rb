class ArticlesController < ApplicationController
	 before_filter :is_login?
	
	def new
		@article = Article.new
	end
	
	def create
		@article = Article.new(article_params)
		if @article.save
			flash[:message] = "Article created successfully"
			redirect_to articles_path
		end
	end

	def index
		@articles = Article.includes(:authors)	
	end

	def show
		@article = Article.find(params[:id])
		@authors = @article.authors
	end

	
	def destroy
		@article = Article.find(params[:id])
		if @article.destroy
			flash[:message] = "Article destroyed successfully"
			redirect_to articles_path
		end
		@authors = @article.authors
	end

	private
	
	def article_params
		params.require(:article).permit!
	end
end