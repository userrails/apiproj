class Api::ArticlesController < Api::BaseControllerController
	before_filter :is_login?

	#curl -X POST -d 'article[name]=article1' http://localhost:3000/api/articles.json
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

	# curl -X GET http://localhost:3000/api/articles/17/show
	def show
		@article = Article.find(params[:id])
		respond_to do |format|
			format.json {render json: @article.to_json}
		end
		@authors = @article.authors
	end

	# curl -X GET http://localhost:3000/api/articles
	def index
		@articles = Article.includes(:authors)

		respond_to do |format|
			format.json {render json: @articles.to_json}
		end
	end

	# curl -X DELETE http://localhost:3000/api/articles/16
	def destroy
		@article = Article.find(params[:id])
		if @article.destroy
			@response_message = {:message => "Article destroyed successfully", :article => @article}
		else
			@response_message = {:message => "Article deletion failed. Please try again!"}
		end
		respond_to do |format|
			format.json {
				render json: @response_message
			}
		end
	end

	private

	def article_params
		params.require(:article).permit!
	end
end