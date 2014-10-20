collection @articles

extends "articles/show"



child :authors do
	attributes :id, :name, :created_at, :updated_at

	node do |author|
		{
			:edit_url => edit_article_url(author)
		}
	end
end