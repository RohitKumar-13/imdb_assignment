require 'rubygems'
require 'selenium-webdriver'

module Configuration
	$MainWebsite = 'http://www.imdb.com/'
    $currentSite

	def openUrl(*args)
		url = args[0]
		@@currentSite = url
		$driver = Selenium::WebDriver.for :firefox
		$driver.manage.timeouts.implicit_wait = 30
		$driver.navigate.to @@currentSite		#start browser and specific url
	end

	def closeUrl
		$driver.quit							#close browser and website
	end
end
