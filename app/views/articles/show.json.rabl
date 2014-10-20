object @article
attributes :id, :name, :created_at, :published_at

node(:edit_url) {|article| edit_article_url(article)}

child :author do
	attributes :id, :name, :created_at, :updated_at
	node(:url) {|author| author_url(author)}
end