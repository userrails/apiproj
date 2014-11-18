class ArticlesController < ApplicationController
	before_filter :is_login?
	
	def new
		@article = Article.new
	end
	
	def create
		#curl -X POST -d 'article[name]=article1' http://localhost:3000/api/articles.json
		@article = Article.new(article_params)
		if @article.save
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
			redirect_to articles_path
		end
		@authors = @article.authors
	end

	private
	
	def article_params
		params.require(:article).permit!
	end
end