class WikiController < ActionController::Base
	def get_id(title)
		# params_id = params[:name]
		Article.where(:title => title).map(&:id)

	end

	def get_links(sourceId)
		Link.where(:source_id => sourceId).map(&:destination_id).uniq
	end

	def get_name(id)
		# params_id = params[:id].to_i
		Article.where(:id => id).map(&:title)
	end

	def get_random_entry ()
		if (@allIds === nil)
			@allIds = Article.pluck(:id);
		end

		get_name(@allIds[rand(@allIds.size)])
	end

	def random_names_front
		startPoint = get_random_entry()
		endPoint = get_random_entry()

		@list_name = [startPoint, endPoint]

		puts get_id(startPoint)
		
		destIds = get_links(get_id(startPoint))

		puts destIds

		destNames = Array.new
		destIds.each do |t|
			destNames.push(get_name(t))
		end
		@link_name = destNames

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

	def haveMet (id, currentDist, idHash)
		pos = id % 5000;
		list = idHash[pos];

		if (idHash[pos] === nil) 
			idHash[pos] = Array.new
			idHash[pos].push([id, currentDist + 1])
			return false;
		end

		idHash[pos].length.times do |l|
			if (l[0] === id) 
				return true;
			end
		end

		idHash[pos].push([id, currentDist + 1])
		return false;
	end

	def bfs (startId, endId)
		hash = Array.new(5000);
		queue = Array.new;

		queue.concat(get_links(startId));

	end

end