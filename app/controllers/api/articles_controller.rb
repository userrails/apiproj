class Api::ArticlesController < ApplicationController

	def create
		@article = Article.new(article_params)
		if @article.save
			@response_message = {:message => "Article created successfully", :article => @article}
		else
			@response_message = {:message => "Article creation failed. Please try again!"}
		end
		respond_to do |format|
			format.json {
				render json: @response_message
			}
		end
	end

	def show
		@article = Article.find(params[:id])
		respond_to do |format|
			format.json {render json: @article.to_json}
		end
		@authors = @article.authors
	end

	def index
		@articles = Article.includes(:authors)

		respond_to do |format|
			format.json {render json: @articles.to_json}
		end
	end

	private

	def article_params
		params.require(:article).permit!
	end
end