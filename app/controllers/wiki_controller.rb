class WikiController < ActionController::Base
	def get_id(params_id)
		# params_id = params[:name]
		Article.where(:title => params_id).map(&:id)

	end

	def get_links(params_id)
		Link.where(:source_id => params_id).map(&:destination_id)
	end

	def get_name(params_id)
		# params_id = params[:id].to_i
		Article.where(:id => params_id.to_i).map(&:title)
	end

	def get_random_entry ()
		if (@allIds === nil)
			@allIds = Article.pluck(:id);
		end

		get_name(@allIds[rand(@allIds.size)])
	end

	def random_names_front
		first_name = get_random_entry()
		second_name = get_random_entry()
		
		#puts second_name
		#@list_name =[first_name,second_name]

		#@list_links = self.get_links(first_name)
		#@link_name=Array.new
		#@list_links.each do |t|

		#	@link_name.push(self.get_name(t).map(&:title))
		#end
		
		render :json => {:names =>@list_name, :links => @link_name}
	end 

	def name_return_links_front
		params_name=params[:name]

		id_for_name=self.get_id(params_name)

		@list_links=self.get_links(id_for_name)
		@list_links.each do |t|
			@link_name.push(self.get_name(t).map(&:title))
		end

		render :json => @link_name
	end

end