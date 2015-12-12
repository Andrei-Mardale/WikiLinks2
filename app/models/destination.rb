class Destination < Article
	has_many :links
	has_many :sources, through => :links
end