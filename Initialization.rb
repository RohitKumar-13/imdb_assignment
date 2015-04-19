require 'rubygems'
require 'selenium-webdriver'

module Configuration
	$MainWebsite = 'http://www.imdb.com/'
    $currentSite

	def openUrl(*args)
		url = args[0]
		@@currentSite = url
		$driver = Selenium::WebDriver.for :firefox
		$wait = Selenium::WebDriver::Wait.new(:timeout => 10)
		$wait.until { !$driver.title.downcase.nil? }
		$driver.navigate.to @@currentSite		#start browser and specific url
	end

	def openUrlInExistingWindow(url)
		$driver.navigate.to url
	end
	def closeUrl
		$driver.quit							#close browser and website
	end
end
