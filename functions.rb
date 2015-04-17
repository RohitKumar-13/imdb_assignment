require 'rubygems'
require 'selenium-webdriver'

module Functions
	def getTitleLinkByClass(className)
		script = "
			function titleLink(title, url){
				this.Title = title;
				this.Url = url;
			}

			var Elements = document.getElementsByClassName('#{className}');
			var result = new Array();

			for(var i = 0; i < Elements.length; i++){
				var Q = new Array();
            	var heading, url;
    			Q.push(Elements[i]);
    			while(Q.length > 0){
        			var curr = Q.shift();
        			for(var j = 0; j < curr.children.length; j++){
                    	var ele = curr.children[j];
            			Q.push(ele);
                    	var Tag = ele.tagName;
                    	if((Tag == 'td' || Tag == 'TD') && ele.className == 'titleColumn'){
                    		var childs = ele.children
                    		url = childs[1].href
                    		heading = childs[1].textContent
                    		var Item = new titleLink(heading, url);
                    		result.push(Item);
                    	}
                	}
            	}
			}
			return result;"

		return $driver.execute_script(script)
	end

	def getTopFivecast
		script = "
			var Elements = document.getElementsByClassName('cast_list');
			var result = new Array();
			var count = 0;

			for(var i = 0; i < Elements.length; i++){
				var Q = new Array();
            	var actorName;
    			Q.push(Elements[i]);
    			while(Q.length > 0){
        			var curr = Q.shift();
        			for(var j = 0; j < curr.children.length; j++){
                    	var ele = curr.children[j];
            			Q.push(ele);
                    	var Tag = ele.tagName;
                    	if((Tag == 'span' || Tag == 'SPAN') && ele.className == 'itemprop'){
                    		actorName = ele.textContent
                    		result.push(actorName);
                    		count++;
                    		if(count == 5){
                    			return result;
                    		}
                    	}
                	}
            	}
			}
		"

		return $driver.execute_script(script)
	end
end