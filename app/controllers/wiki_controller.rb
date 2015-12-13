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

	def name_return_links_front
		params_name=params[:name]

		id_for_name = get_id(params_name)

		destIds = get_links(id_for_name).compact
		@link_name = destIds.map{|t| get_name(t)}

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
		@pathData = bfs(get_id(startPoint).to_i, links[randomNumber].to_i)
		render :json => {:names =>@list_name, 
						 :links => @link_name, 
						 :distance => @pathData[:distance],
						 :path => @pathData[:path]
						}
	end


	def haveMet (destId, srcId, currentDist, idHash)
		pos = destId % 5000;
		list = idHash[pos];

		if (idHash[pos] === nil) 
			idHash[pos] = Array.new
			idHash[pos].push([destId, currentDist + 1, srcId])
			return false;
		end

		idHash[pos].each do |l|
			if (l[0] === destId) 
				return true;
			end
		end

		idHash[pos].push([destId, currentDist + 1, srcId])
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

	def getPrev (id, idHash)
		puts id
		pos = id % 5000;
			idHash[pos].each do |l|
				if (l[0] === id)
					return l[2];
				end
			end

		return -9999
	end

	def bfs (startId, endId)
		hash = Array.new(5000);
		queue = Array.new;

		haveMet(startId, -1, -1, hash);

		nextIds = get_links(startId);
		nextIds.each do |id|
			haveMet(id, startId, 0, hash);
			queue.push(id);
		end

		finalDist = 0
		while (queue.any? && finalDist === 0) do
			currentId = queue.shift;
			currentDist = getDist(currentId, hash)

			nextIds = get_links(currentId);
			nextIds.each do |id|
				if (id === endId)
					haveMet(id, currentId, currentDist, hash)
					finalDist = currentDist + 1
					break;
				else
					if (!(haveMet(id, currentId, currentDist, hash)))
						queue.push(id);
					end
				end
			end
		end

		path = Array.new

		currentId = endId
		while (currentId > 0)
			path.unshift(get_name(currentId))
			currentId = getPrev(currentId, hash)
			puts "CURRENT ID: " + currentId.to_s
		end

		puts path

		return {:distance => finalDist, :path => path}
	end

end