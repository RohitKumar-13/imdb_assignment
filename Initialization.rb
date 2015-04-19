require 'rubygems'
require 'selenium-webdriver'

module Configuration
	$MainWebsite = 'http://www.imdb.com/'
    $currentSite

	def openUrl(*args)
		url = args[0]
		@@currentSite = url
		$driver = Selenium::WebDriver.for :firefox
		$driver.manage.timeouts.page_load = 30
		$driver.navigate.to @@currentSite		#start browser and specific url
	end
	def openTempUrl(*args)
		url = args[0]
		@@currentSite = url
		$tempdriver = Selenium::WebDriver.for :firefox
		$tempdriver.manage.timeouts.page_load = 30
		$tempdriver.navigate.to @@currentSite		#start browser and specific url
	end

	def openUrlInExistingWindow(url)
		$driver.navigate.to url
	end
	def closeUrl
		$driver.quit							#close browser and website
	end

	def closeTempUrl
		$tempdriver.quit							#close browser and website
	end
end
