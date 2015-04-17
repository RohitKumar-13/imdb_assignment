require 'rubygems'
require 'selenium-webdriver'
require './Initialization.rb'
require './functions.rb'

class IMDB
	include Configuration
	include Functions
end

object = IMDB.new()

object.openUrl("http://www.imdb.com/chart/top?ref_=nv_sr_1")

movieTitleLink = object.getTitleLinkByClass('lister-list')
#puts movieTitleLink
puts "All 250 movies extracted"
if !movieTitleLink.nil?
	movieTitleLink.each do |item|
		object.openUrlInExistingWindow(item['Url'])
		fiveCast =  object.getTopFivecast
		puts fiveCast
		puts
	end
end
object.closeUrl
