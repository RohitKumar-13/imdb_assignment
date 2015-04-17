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

object.closeUrl
