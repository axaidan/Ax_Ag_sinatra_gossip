class Gossip
	attr_reader :author, :content

	def initialize (input_name, input_gossip)
		@author = input_name
		@content = input_gossip
	end

	def save
		CSV.open("./db/gossip.csv", "ab") do |csv|
			csv << [@author, @content]
		end
	end

	def self.all
		all_gossips = []
		CSV.read("./db/gossip.csv").each do |csv_line|
			all_gossips << Gossip.new(csv_line[0], csv_line[1])
		end
		return all_gossips
	end

	def self.find(n)
		found = self.all[n]
	end

	def self.rewrite_db(arr)
		db = File.open("./db/gossip.csv", "w")
		arr.each do |gossip|
			db.puts "#{gossip.author},#{gossip.content}"
		end
		db.close
	end
end
