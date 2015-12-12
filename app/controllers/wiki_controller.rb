class WikiController < ActionController::Base
	def get_id
		params_id = params[:name].to_i
		render :json => Article.where(:title => params_id).map(&:title)

	end
	def get_id_list
		params_id = params[:id].to_i
		render :json => Link.where(:source_id =>params_id).map(&:destination_id)	
	end
	def get_name
		params_id = params[:id].to_i
		render :json => Article.where(:id => params[:id]).map(&:title)
	end
end