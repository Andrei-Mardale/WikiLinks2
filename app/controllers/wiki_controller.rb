class WikiController < ActionController::Base
	def get_id
		params_id = params[:name]
		@id_for_name => Article.where(:title => params_id).map(&:title)

	end
	def get_links
		params_id = params[:id].to_i
		@id_destinations = Link.where(:source_id =>params_id).map(&:destination_id)	
	end
	def get_name
		params_id = params[:id].to_i
		@name = Article.where(:id => params[:id])
	end
end