	var isInited =false
	var	projects = []
	var	users = []
	var	grades = []
	var	curriculums = []

	function init(database,token,user_id){
		var jsondata = {
				"database" :database ,
				"token" : token
			};
		
		  // get all grade
		$.ajax({
			url : "/WSG/grade/get/all",
			type : "POST",
			data : JSON.stringify(jsondata),
			dataType : "json",
			success : function(data, textStatus, jqXHR) {
				if(data.code=="failure"){

				}else{
                    grades = $.parseJSON(data.obj);
					}
				}
	
			})
		
		// get all curriculum
		$.ajax({
			url : "/WSG/curriculum/get/all",
			type : "POST",
			data : JSON.stringify(jsondata),
			dataType : "json",
			success : function(data, textStatus, jqXHR) {
					curriculums = $.parseJSON(data.obj);
				}
	
			})
		
		// get all users
		$.ajax({
			url :  "/WSG/user/get/all",
			type : "POST",
			data : JSON.stringify(jsondata),
			dataType : "json",
			success : function(data, textStatus, jqXHR) {
				if(data.code=="failure"){

				}else{
					users = $.parseJSON(data.obj);
					}
				}
	
			})
		
		// get all project
		$.ajax({
			url :  "/WSG/project/get/all",
			type : "POST",
			data : JSON.stringify(jsondata),
			dataType : "json",
			success : function(data, textStatus, jqXHR) {
				if(data.code=="failure"){
		                     //$.notify('No project in this community .', 'warn');
		                }else{
		                     var json = $.parseJSON(data.obj);
		                     for(var i in json){
		                     		 projects[json[i].id]=json[i]
		                       
		                     }
		                     getMyProjectAsAuthor(database,token,user_id)
		                     getAllTeacher(database,token,user_id)
		                     getProjectAsMember(database,token,user_id)
		                     getGrade(database,token,user_id)
		                     getCurriculum(database,token,user_id)
		                }
				
				}
			})				
							
	}
	
	function getMyProjectAsAuthor(database,token,user_id){
		
		var jsonMyProject = {
		"database" :database ,
		"token" : token,
		"authorid":user_id
		};
		// get my project as author
		$.ajax({
			url :  "/WSG/me/project/asauthor/get",
			type : "POST",
			data : JSON.stringify(jsonMyProject),
			dataType : "json",
			success : function(data, textStatus, jqXHR) {
				if(data.code=="failure"){
	                //$.notify('The author do no have project .', 'warn');
	           }else{
	                var json = $.parseJSON(data.obj);
	                for(var i in json){
	                	if(null!=projects[json[i].project_id]&&projects[json[i].project_id]!=""){
	                			projects[json[i].project_id] = $.extend(projects[json[i].project_id],{"isMyProject":true,"role":json[i].type})
	                	}
	                  
	                }
	           }
				}
			})
	}
	
	function getAllTeacher(database,token,user_id){
		var jsonMyProject = {
				"database" :database ,
				"token" : token,
				"authorid":user_id
				};
		// get all project teacher
		$.ajax({
			url :  "/WSG/project/author/get/all",
			type : "POST",
			data : JSON.stringify(jsonMyProject),
			dataType : "json",
			success : function(data, textStatus, jqXHR) {
				if(data.code=="failure"){
                   // $.notify('No author in this community .', 'warn');
               }else{
                    var json = $.parseJSON(data.obj);
                    for(var i in json){
                    		if(null!=projects[json[i].project_id]){
                    			if(null==projects[json[i].project_id].authors){
                    				 projects[json[i].project_id] = $.extend(projects[json[i].project_id],{"authors":[json[i]]})
                    			}else{
                    				projects[json[i].project_id].authors.push(json[i])
                    			}
                        			
                    			
                    		}
                    }
               }
				}
			})
	}
	
	function getProjectAsMember(database,token,user_id){
		var jsonMyProject = {
				"database" :database ,
				"token" : token,
				"authorid":user_id
				};
		// get my project as member
	$.ajax({
		url :  "/WSG/me/project/asmember/get",
		type : "POST",
		data : JSON.stringify(jsonMyProject),
		dataType : "json",
		success : function(data, textStatus, jqXHR) {
			if(data.code=="failure"){
                //$.notify('No member in this project.', 'warn');
           }else{
                var json = $.parseJSON(data.obj);
                for(var i in json){
                	if(null!=projects[json[i].project_id]&&projects[json[i].project_id]!=""){
                		projects[json[i].project_id] = $.extend(projects[json[i].project_id],{"isMember":true,"member_role":json[i].type})
                	}
                  
                }
           }
			}
		})
		
	}
	
	
	function getGrade(database,token,user_id){
		var jsonMyProject = {
				"database" :database ,
				"token" : token,
				"authorid":user_id
				};
		// get  project  grade 
	$.ajax({
		url : "/WSG/project/grade/get/all",
		type : "POST",
		data : JSON.stringify(jsonMyProject),
		dataType : "json",
		success : function(data, textStatus, jqXHR) {
			if(data.code=="failure"){
                //$.notify('No grade in this project .', 'warn');
           }else{
                var json = $.parseJSON(data.obj);
                for(var i in json){
                		if(null!=projects[json[i].project_id]){
                			if(null!=projects[json[i].project_id].grade){
                				 projects[json[i].project_id].grade.push(json[i])
                			}else{
                				 projects[json[i].project_id] = $.extend(projects[json[i].project_id],{"grade":[json[i]]})
                			}
                    			
                		}
                  
                }
           }
			}
		})
	}
	
	
	function getCurriculum(database,token,user_id){
		var jsondata = {
				"database" :database ,
				"token" : token
			};
		// get all project curriculum
		$.ajax({
			url :  "/WSG/project/curriculum/get/all",
			type : "POST",
			data : JSON.stringify(jsondata),
			dataType : "json",
			success : function(data, textStatus, jqXHR) {
				if(data.code=="failure"){
                    //$.notify('No curriculum in this community .', 'warn');
               }else{
            	    
                    var json = $.parseJSON(data.obj);
                    for(var i in json){
                    		if(null!=projects[json[i].project_id]){
                    			if(null!=projects[json[i].project_id].curriculum){
                   				 projects[json[i].project_id].curriculum.push(json[i])
                   			}else{
                   			 projects[json[i].project_id] = $.extend(projects[json[i].project_id],{"curriculum":[json[i]]})
                   			}
                        			
                    	}
                      
                    }
               }
				}
			})
	}
	$(document).ajaxStop(function() {
		if(!isInited){
			if (typeof(Storage) !== "undefined") {
				localStorage= null;
				localStorage.setItem("projects", JSON.stringify(projects));
				localStorage.setItem("users", JSON.stringify(users));
				localStorage.setItem("grades", JSON.stringify(grades));
				localStorage.setItem("curriculums", JSON.stringify(curriculums));
				initPage();
			} else {
				// Sorry! No Web Storage support..
			}
			isInited=true
		}
	});
		