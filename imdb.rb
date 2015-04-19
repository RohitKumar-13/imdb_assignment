require 'rubygems'
require 'selenium-webdriver'
require 'sqlite3'
require './Initialization.rb'
require './functions.rb'

class IMDB
	include Configuration
	include Functions
end

class MovieArray
	attr_accessor :movies
	def initialize
		@movies = Array.new()
	end

	def add(mov)
		@movies.push(mov)
	end

	def	getSize
		return @movies.length
	end

	def getArrayString
		return @movies.join("--")
	end
end
=begin
class MovieObject
	attr_accessor :actor, :movie
	def initialize(act, mov)
		@actor = act
		@movie = mov
	end
end
=end

object = IMDB.new()

object.openUrl("http://www.imdb.com/chart/top?ref_=nv_sr_1")

#================= Extract link of all 250 movies===============#
movieTitleLink = object.getTitleLinkByClass('lister-list')
#puts movieTitleLink
puts "All 250 movies extracted"

allActorMovie = Hash.new()

puts "Extracting top five actor names in all 250 movies ... Please Wait ...."
i = 1

movieTitleLink.each do |item|
	object.openUrlInExistingWindow(item['Url'])
	fiveCast =  object.getTopFivecast
	if !fiveCast.nil?
		fiveCast.each do |actor|
			if allActorMovie.has_key?(actor) && allActorMovie.length > 0
				allActorMovie[actor].add(item['Title'])
			else
				mobj = MovieArray.new()
				mobj.add(item['Title'])
				allActorMovie[actor] = mobj
			end
		end
	else
		fullcast = $driver.find_element(:link_text, "See full cast");
		link = fullcast.attribute('href')
		object.closeUrl
		object.openUrl(link)
		fiveCast =  object.getTopFivecast

		fiveCast.each do |actor|
			if allActorMovie.has_key?(actor) && allActorMovie.length > 0
				allActorMovie[actor].add(item['Title'])
			else
				mobj = MovieArray.new()
				mobj.add(item['Title'])
				allActorMovie[actor] = mobj
			end
		end
	end
	i = i + 1
end


#================Creating Database and puting valuse in database===================#
puts "creating database . . ."
db = SQLite3::Database.new "imdb.db"
rows = db.execute "create table actormovie (\nname varchar(30),\ntimes_in_250 int, \nmovies varchar(300));\n"
allActorMovie.each do |key, value|
	db.execute("INSERT INTO actormovie (name, times_in_250, movies) 
            VALUES (?, ?, ?)", [key, value.getSize, value.getArrayString])
end

db.execute( "select * from actormovie" ) do |row|
   puts row

   #actor name
   #no of times in 250 movies
   #movies names
end

object.closeUrl