function sessionTimeOut(sessionTime){
	$.sessionTimeout({
	  warnAfter: 60*60*1000,
	  redirAfter: 10000,
	  keepAliveAjaxRequestType:"GET",	
	  redirUrl:"/ITM3/",
	  keepAliveUrl:"/ITM3/session",
	  logoutUrl:"/ITM3/?id=3"
	});
	
}


function sleepFor( sleepDuration ){
		    var now = new Date().getTime();
		    while(new Date().getTime() < now + sleepDuration){ /* do nothing */ } 
		}


	var getUrlParameter = function getUrlParameter(sParam) {
	    var sPageURL = decodeURIComponent(window.location.search.substring(1)),
	        sURLVariables = sPageURL.split('&'),
	        sParameterName,
	        i;

	    for (i = 0; i < sURLVariables.length; i++) {
	        sParameterName = sURLVariables[i].split('=');

	        if (sParameterName[0] === sParam) {
	            return sParameterName[1] === undefined ? true : sParameterName[1];
	        }
	    }
	};
	