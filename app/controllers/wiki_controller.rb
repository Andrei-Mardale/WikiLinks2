class WikiController < ActionController::Base
	def get_id(params_id)
		# params_id = params[:name]
		@id_for_name = Article.where(:title => params_id).map(&:title)

	end

	def get_links(params_id)
		# params_id = params[:id].to_i
		@id_destinations = Link.where(:source_id =>params_id).map(&:destination_id)	
	end

	def get_name(params_id)
		# params_id = params[:id].to_i
		@name = Article.where(:id => params[:id])
	end

	def random_names_front
		num1=rand(50000000)
		num2=rand(50000000)
		while num1==num2
			num2=rand(50000000)
		end	

		first_name = self.get_name(num1)
		second_name = self.get_name(num2)
		@list_name =[first_name,second_name]

		@list_links = self.get_links(first_name)
		@link_name=Array.new
		@list_links.each do |t|
			@link_name=push(Article.where(:id => t))
		end
		
		render :json => {:names =>@list_name, :links => @link_name}
	end 

	def name_return_links_front
		params_name=params[:name]

		id_for_name=self.get_id(params_name)

		@list_links=self.get_links(id_for_name)
		@list_links.each do |t|
			@link_name=push(Article.where(:id => t))
		end

		render :json => @link_name
	end

end