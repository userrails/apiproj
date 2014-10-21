collection @articles

extends "articles/show"

child :authors do
	attributes :id, :name, :created_at, :updated_at

	node do |author|
		{
			:new_url => new_author_url(author)
		}
	end
end