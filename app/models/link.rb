class Link < ActiveRecord::Base
	
	belongs_to :sources
	belongs_to :destinations
end