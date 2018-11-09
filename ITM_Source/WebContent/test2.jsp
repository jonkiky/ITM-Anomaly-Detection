<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <!--Import Google Icon Font-->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <!--Import materialize.css-->
    <link type="text/css" rel="stylesheet" href="css/materialize.min.css" media="screen,projection"/>

    <!--Let browser know website is optimized for mobile-->
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta charset="UTF-8">

    <style>
        main {
            margin-top: 20px;
        }
    </style>


</head>

<body>


<main>
    <div class="container">
        
    </div>
</main>




<!--Import jQuery before materialize.js-->
<script src="js/jquery-3.1.0.js"></script>
<script type="text/javascript" src="js/materialize.min.js"></script>
<script type="text/javascript">

function getServices(){
	
	var projectJson = {
			"database" :"itm3" ,
			"token" : '20171025102545588494'
		};

		$.ajax({
					url :  "http://tccl.rit.albany.edu:8080/WSG/get/services/",
					type : "POST",
					data : JSON.stringify(projectJson),
					dataType : "json",
					success : function(data, textStatus, jqXHR) {
						 var json = $.parseJSON(data.obj);
						 for(var j in json){
							 //getServiceRecord(json[j].requested_router,json[j].sqlquery)
							 if(json[j].method=="POST")
							 	getServiceRecord(json[j].requested_router,json[j].sqlquery,"post");
						 }
					}
		})
}

//var path = "/thread/update";
//var query = 'update thread_table set threadfocus ="@threadfocus", modify_time="@mtime", keywords="@keywords",resource="@resource" ,author_id="@authorid" where   id=@threadid';
//var method ="post";
//getServiceRecord(path,query,method);


function getServiceRecord(path,query,method){
	var projectJson = {
			"database" :"itm3" ,
			"token" : '20171025102545588494',
			"service_path":path
		};

		$.ajax({
					url :  "http://itm.arcc.albany.edu/WSG/service_record/getbypath/",
					type : "POST",
					data : JSON.stringify(projectJson),
					dataType : "json",
					success : function(data, textStatus, jqXHR) {
						if(data.code="success"){
							var json = $.parseJSON(data.obj);
							var paramters = query.match(/\@\w*/g);
							if(null==paramters){
								// if @word not exist
								var postDate ={
									"database":"localdb",
									"token" : '20171025102545588494',
								}
								// sent message 
								postMessage(path,postDate)
								
								
							}else{
								// if has @word then get @word value
								var c=query;
								if(null!=json&&null!=c){
									for(var p in paramters){
										var content= c.split(paramters[p])[0];
										c= c.split(paramters[p])[1];
										json[0].user_query=json[0].user_query.replace(content," ");
									}
									json[0].user_query=json[0].user_query.replace(c," ");
									
									// after replace non meaningful words , @word's value remain in json[0].user_query
									
									var value =$.trim(json[0].user_query).split(" ")
									console.log("paramters")
									console.log(paramters)
									console.log("value")
									console.log(value)
									var postDate ={
										"database":"localdb",
										"token" : '20171025102545588494',
									}
									for(var i in value){
										postDate[paramters[i].substring(1,paramters[i].length)]=value[i]
									}
									//console.log(postDate)
									//sent message 
									postMessage(path,postDate)
								}
							}
						}
					
					}
		})
	
	
}

function postMessage(path,data){
	console.log("Path")
	console.log(path)
	console.log("Data")
	console.log(data)
		$.ajax({
					url :  "http://itm.arcc.albany.edu/WSG"+path,
					type : "POST",
					data : JSON.stringify(data),
					dataType : "json",
					success : function(data, textStatus, data) {
						console.log("success");
					
					},
					error:function(jqXHR, textStatus,errorThrown ){
						console.log("err");
					}
		})
}


var postDate ={"database":"localdb","token":"2017102510080929505"};

$.ajax({
	url :  "http://itm.arcc.albany.edu/WSG/project/get/all",
	type : "POST",
	data : JSON.stringify(postDate),
	dataType : "json",
	success : function(data, textStatus, data) {
		console.log("success");
	
	},
	error:function(jqXHR, textStatus,errorThrown ){
		console.log("err");
	}
})

</script>
</body>
</html>