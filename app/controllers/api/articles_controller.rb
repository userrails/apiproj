class Api::ArticlesController < Api::BaseController
	skip_before_filter :verify_authenticity_token
	before_filter :authenticate_user
	respond_to :json, :xml

	#curl -X POST -d 'article[name]=article1&api_key=peE5kohKwN' http://localhost:3000/api/articles.json
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

			format.xml {
				render xml: @response_message
			}
		end
	end

	# curl -X GET -d 'api_key=peE5kohKwN' http://localhost:3000/api/articles/33
	def show
		@article = Article.find(params[:id])
		respond_to do |format|
			format.json {render json: @article.to_json}
			format.xml {render xml: @article.to_xml}
		end
	end

	# curl -X GET -d 'api_key=peE5kohKwN' http://localhost:3000/api/articles
	def index
		@articles = Article.includes(:authors)

		respond_to do |format|
			format.json {render json: @articles.to_json}
			format.xml {render json: @articles.to_xml}
		end
	end

	# curl -X DELETE -d 'api_key=peE5kohKwN' http://localhost:3000/api/articles/16
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
			format.xml {
				render xml: @response_message
			}
		end
	end

	private
	def article_params
		params.require(:article).permit!
	end
end