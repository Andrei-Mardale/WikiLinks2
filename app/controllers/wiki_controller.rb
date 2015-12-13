class WikiController < ActionController::Base
	def get_id(title)
		# params_id = params[:name]
		Article.where(:title => title).map(&:id)[0]

	end

	def get_links(sourceId)
		Link.where(:source_id => sourceId).map(&:destination_id).uniq
	end

	def get_name(id)
		# params_id = params[:id].to_i
		Article.where(:id => id).map(&:title)[0]
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
			if (name=get_name(t))!=[]
				destNames.push(name)
			end
		end
		@link_name = destNames

		render :json => {:names =>@list_name, :links => @link_name}
	end 

	def name_return_links_front
		params_name=params[:name]

		id_for_name=self.get_id(params_name)

		@list_links=self.get_links(id_for_name)
		@link_name = Array.new
		@list_links.each do |t|
			if (name=get_name(t))!=[]
				@link_name.push(name)
			end
		end

		render :json => @link_name
	end
	def cale_random_front
		startPoint = get_random_entry()

		random_link=get_id(startPoint)

		# @link_name=name_return_links_front
		links=get_links(random_link).compact
		@link_name = links.map{|t| get_name(t)}
	
		number_of_iter=rand(3..14)
		i=0
		while i<number_of_iter do-1
			randomNumber = rand(links.length - 1)
			links = get_links(links[randomNumber])
			
			i += 1;
		end
		
		randomNumber = rand(links.length - 1)

		endPoint = get_name(links[randomNumber])
		@list_name = [startPoint, endPoint]
		@distance = bfs(get_id(startPoint).to_i, links[randomNumber].to_i)
		render :json => {:names =>@list_name, :links => @link_name, :distance => @distance}
	end


	def haveMet (id, currentDist, idHash)
		pos = id % 5000;
		list = idHash[pos];

		if (idHash[pos] === nil) 
			idHash[pos] = Array.new
			idHash[pos].push([id, currentDist + 1])
			return false;
		end

		idHash[pos].each do |l|
			if (l[0] === id) 
				return true;
			end
		end

		idHash[pos].push([id, currentDist + 1])
		return false;
	end

	def getDist (id, idHash)
		pos = id % 5000;

		idHash[pos].each do |l|
			if (l[0] === id)
				return l[1];
			end
		end

		return -9999
	end

	def bfs (startId, endId)
		puts "ASdadasdasa"
		puts startId
		puts endId
		puts "asdasddasdsdasdas"
		hash = Array.new(5000);
		queue = Array.new;

		haveMet(startId, -1, hash);

		nextIds = get_links(startId);
		nextIds.each do |id|
			haveMet(id, 0, hash);
			queue.push(id);
		end

		while queue.any? do
			currentId = queue.shift;
			currentDist = getDist(currentId, hash)

			nextIds = get_links(currentId);
			nextIds.each do |id|
				if (id === endId)
					return currentDist + 1
				else
					if (!(haveMet(id, currentDist, hash)))
						queue.push(id);
					end
				end
			end
		end

		return -1
	end

end