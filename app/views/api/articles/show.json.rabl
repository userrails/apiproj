object @article
attributes :id, :name, :created_at

node do |article|
	{
		:last_updated_at => time_ago_in_words(article.updated_at),	
		:edit_url => edit_article_url(article)
	}
end