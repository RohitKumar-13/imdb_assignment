require 'rubygems'
require 'selenium-webdriver'

module Functions
	def getTitleLinkByClass(className)
		script = "var Elements = document.getElementsByClassName('#{className}');
		return Elements;"

		return $driver.execute_script(script)
	end
end