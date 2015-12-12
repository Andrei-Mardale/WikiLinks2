class Source<Article
	has_many :links
	has_many :destinations, => through :links
end