	<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<!--Import Google Icon Font-->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<!--Import materialize.css-->
<link type="text/css" rel="stylesheet" href="css/materialize.css"
	media="screen,projection" />
<link type="text/css" rel="stylesheet" href="css/customerize.css"
	media="screen,projection" />
	
	
<link type="text/css" rel="stylesheet"
	href="css/jquery-ui.css" media="screen,projection" />
<!--Let browser know website is optimized for mobile-->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta charset="UTF-8">
<script src="js/jquery-3.1.0.js"></script>
<script src="js/jquery-ui.js"></script>
<script src="js/jquery.sessionTimeout.js"></script>
<style>
@media ( min-width : 768px) {
	.length {
		width: 130px;
	}
	.languagenav {
		width: 60px;
	}
}

.links line {
	stroke: #999;
	stroke-opacity: 0.6;
}

.nodes circle {
	stroke: #fff;
	stroke-width: 1.5px;
}

.container {
	margin: 0 auto;
	max-width: 1280px;
}



ul.side-nav.fixed li.logo {
	text-align: center;
	margin-top: 12px;
	margin-bottom: 62px;
}

nav {
	   height: 50px;
    line-height: 50px;
    font-size: 22px;
    background: none;
}

.collapsible-body {
	padding: 0px !important;
}

	

.tabs .tab a {
  color: #607d8b;
}

.tabs .tab a:hover, .tabs .tab a.active {
  background-color: transparent;
  color: #607d8b;
}

.tabs .tab.disabled a,
.tabs .tab.disabled a:hover {
  color: #607d8b;
  cursor: default;
}

.tabs .indicator {
  background-color: #607d8b;
}
</style>


</head>

<body>

	<header>
			<%@ include file="header_without_nav_bar.jsp" %>

	</header>

	<main>
	
	<div class="container" style="padding-top: 10px;">
	  <div class="row">
    <div class="col s12">
      <ul class="tabs">
        <li class="tab col s4"><a class="active" href="#test1">My Communities</a></li>
        <li class="tab col s4"><a  href="#test2">Explore KF Communities</a></li>
         <li class="col s3" id="btn-new-community">
         <a href="register_community.jsp" target="_blank"
						class="btn col s10 offset-s2">New Community</a> 
			</li>
      </ul>
    </div>
    <div id="test1" class="col s12">
		<div class="row">
			<div class="col s12">
				<div class="row">
					<div class="col s12" id="project-card"></div>

				</div>
			</div>
			
		</div>

	</div>
    <div id="test2" class="col s12">
	    <div class="row">
			<div class="col s12">
				<div class="row">
					<div class="col s12" id="project-card-explore"></div>

				</div>
			</div>
			
		</div>
    
    </div>
  </div>
		
	</div>
	</main>

<div id="modal1" class="modal">
    <div class="modal-content" id="communities">
       
    </div>
    <div class="modal-footer">
        <a href="#!" class="modal-action modal-close waves-effect waves-green btn-flat ">Close</a>
    </div>
</div>


<div id="modal2" class="modal">
    <div class="modal-content">
    <div class="row">
        <div class="input-field col s12">
          <input  id="username" type="text" class="validate">
          <label for="username">User Name</label> 
        </div>
      </div>
     <div class="row">
        <div class="input-field col s12">
          <input  id="fname" type="text" class="validate">
          <label for="fname">first Name</label> 
        </div>
      </div>
          <div class="row">
        <div class="input-field col s12">
          <input  id="lname" type="text" class="validate">
          <label for="lname">last Name</label> 
        </div>
      </div>
        <div class="row">
        <div class="input-field col s12">
          <input  id="email" type="email" class="validate">
          <label for="email">Email</label> 
        </div>
      </div>
         <div class="row">
        <div class="input-field col s12">
          <input  id="password" type="text" class="validate">
          <label for="password">Password</label> 
        </div>
      </div>
      
     
    </div>
    <div class="modal-footer">
    	<a  id="register" class="waves-effect waves-light btn">Register</a>
        <a href="#!" class="modal-action modal-close waves-effect waves-green btn-flat ">Close</a>
    </div>
</div>





<div id="request-to-add-community" class="modal">
  	<input type="hidden" id="kfcommunity">
    <div class="modal-content">
    	<h4> Request to add a kf community</h4>				
    <div class="row">
        <div class="input-field col s12">
          <input  id="kfemail" type="text" class="validate">
          <label for="kfemail">Email:</label> 
        </div>
      </div>
     <div class="row">
        <div class="input-field col s12">
          <input  id="kfusername" type="text" class="validate">
          <label for="kfusername">User name of  KF:</label> 
        </div>
      </div>
         <div class="row">
        <div class="input-field col s12">
          <input  id="kfpassword" type="text" class="validate">
          <label for="kfpassword">password of  KF</label> 
        </div>
      </div>
      
     
    </div>
    <div class="modal-footer">
    	<a  id="btn-community-register" class="waves-effect waves-light btn">Register</a>
        <a href="#!" class="modal-action modal-close waves-effect waves-green btn-flat ">Close</a>
    </div>
</div>



	<!--Import jQuery before materialize.js-->
	<script type="text/javascript" src="js/materialize.min.js"></script>
	<script src="https://d3js.org/d3.v4.min.js"></script>
	<script src="js/notify.js"></script>
	<script src="js/itm.js?id=24"></script>
	<script>
	 
	

	$("#page_title").html("Community")
	$(".button-collapse").sideNav();
	
	$(".in-community").hide();
	$("#show_slide").click(function() {
								$('.button-collapse').sideNav('show');
							});
	
	$(".modal").modal({resizable: true});
	$(document).ready(function() {
		
		// init user name
		var username =getUrlParameter('username');
		
		console.log("")
		$("#user-name").text(username)
		
		
		
		/*  function for future , if current user is first time login itm , let he/she to provides more information about them self. 
 		
		function checkUserIfUserHasRegisteredAsITMUser(str_id){
			$.ajax({
	              type: "POST",
	              url:  "/WSG/user/get/bykfid",
	              dataType : "json",
	              data : JSON.stringify({"token":"7897aasdfasdf2312312","database":"itm3","kf_id":str_id}),
	              success: function(data, textStatus, jqXHR)
	                {	console.log("checkUserIfUserHasRegisteredAsITMUser:"+data)
	                    if(data.code=="failure"&&$.trim(data.desc)=="No data aviliable."){
	                    	 //$("#modal2").data("str_id",str_id)
	                    	 //$("#modal2").modal('open');
	                    }
	                  
	                },
	                error: function (jqXHR, textStatus, errorThrown)
	                {
	                    console.log(textStatus);
	                },
	                beforeSend: function ()
	                {
	                }
	            });
		}*/
		
	
	
		
		
		function get_Communities(){
			var token = getUrlParameter('token');
			var kf_token = getUrlParameter('kf-token');
			var kfurl = getUrlParameter('kfurl');
			if(""==kf_token||""==kfurl||null==kfurl||null==kf_token){
				token= '<%=session.getAttribute("token")%>';
				kfurl= '<%=session.getAttribute("kfURL")%>';
				kf_token= '<%=session.getAttribute("kftoken")%>';
			}
			var pwd = '<%=session.getAttribute("pwd")%>';
			if('null'==kf_token||'null'==kfurl){
				if(""!=token&&null!=token){  //if user is not kf6 user, only show local communities
					console.log("ITM User")
					$.ajax({
			              type: "POST",
			              url:  "/IIUSs/kf6/getLocalCommunities",
			              contentType:"application/x-www-form-urlencoded",
			              data : {'email':'<%=session.getAttribute("email")%>','password':pwd},
			              dataType: 'text',
			              success: function(data, textStatus, jqXHR)
			                {
			            	    var kf_user_str_id="";
			                    var o = JSON.parse(data)
			                    
			                    if(o.code=="success"){
			                    	 var d = $.parseJSON(data); 
			                    	 var json =d.obj;
			                    	  for(var i in json){
			                    		  if(json[i].isITM){
			                    			  var html='<div class="card horizontal" id="2">'+
				  		                    	'<div class="card-stacked"><div class="card-stacked"><div class="card-content">'+
				  		                    	'<h5>'+json[i].community+'</h5><br><a href="javascript:enter(\''
				  		                    			+json[i].community_id+'\',\''
				  		                    			+json[i].localdb+'\',\''
				  		                    			+json[i].role+'\',\''
				  		                    			+json[i].str_id+'\')" class="btn ">Enter</a></div></div></div>'
				  		                    	$('#project-card').append(html);
				  		                    			if(json[i].str_id!=""){
				  		                    				kf_user_str_id=json[i].str_id
				  		                    			}
				  		                    	console.log("str_id"+kf_user_str_id)
			                    		  }else{
			                    			  var html='<div class="card horizontal" id="2">'+
			  		                    		'<div class="card-stacked"><div class="card-stacked"><div class="card-content">'+
			  		                    		'<h5>'+json[i].community+'</h5><br><a href="javascript:AccessCode(\''+json[i].community.replace(/'/g,"\\\'").replace(/"/g,"\\\"")+'\');" class="btn ">Request to add community</a></div></div></div>'
			  		                    		$('#project-card-explore').append(html);
			                    		  }
			                    	  }
			                    }else{
			                        $.notify('Wrong username or password, try again . ', 'warn');
			                    }
			                    
			                    MyRegistered()
			                },
			                error: function (jqXHR, textStatus, errorThrown)
			                {
			                    console.log(textStatus);
			                },
			                beforeSend: function ()
			                {
			                }
			            });
				}
			}else{
				 //if user is  kf6 user
				$.ajax({
		              type: "POST",
		              url:  "/IIUSs/kf6/getCommunities",
		              contentType:"application/x-www-form-urlencoded",
		              data : {'token':kf_token,'kfurl':kfurl},
		              dataType: 'text',
		              success: function(data, textStatus, jqXHR)
		                { 	
		            	  
		            	  	var kf_user_str_id="";
		            		console.log("KF User")
		                    var o = JSON.parse(data)
		                    if(o.code=="success"){
		                    	 var d = $.parseJSON(data); 
		                    	 var json =d.obj;
		                    	  for(var i in json){
		                    		  if(json[i].isITM){
		                    			  var html='<div class="card horizontal" id="2">'+
			  		                    	'<div class="card-stacked"><div class="card-stacked"><div class="card-content">'+
			  		                    	'<h5>'+json[i].community+'</h5><br><a href="javascript:enter(\''
			  		                    			+json[i].community_id+'\',\''
			  		                    			+json[i].localdb+'\',\''
			  		                    			+json[i].role+'\',\''
			  		                    			+json[i].str_id+'\')" class="btn ">Enter</a></div></div></div>'
			  		                    	$('#project-card').append(html);
		                    				if(json[i].str_id!=""){
	  		                    				kf_user_str_id=json[i].str_id
	  		                    			}
	  		                    			console.log("str_id"+kf_user_str_id)
                    			
		                    		  }else{
		                    			  var html='<div class="card horizontal" id="2">'+
		  		                    		'<div class="card-stacked"><div class="card-stacked"><div class="card-content">'+
		  		                    		'<h5>'+json[i].community+'</h5><br><a href="javascript:AccessCode('+json[i].community_id+');" class="btn ">Request to add community</a></div></div></div>'
		  		                    		$('#project-card-explore').append(html);
		                    		  }
		                    	  }

		                    	
		                    }else{
		                        $.notify('Wrong username or password, try again . ', 'warn');
		                    }
		                    MyRegistered()
		                },
		                error: function (jqXHR, textStatus, errorThrown)
		                {
		                    console.log(textStatus);
		                },
		                beforeSend: function ()
		                {
		                }
		            });
			}
	        
	}
		
		
		
		get_Communities();
		
		
		
		
		function MyRegistered(){
			console.log("MyRegistered")
			var d2 ={
					'token':'7897aasdfasdf2312312',
	                'database':'itm3',
					"email":'<%=session.getAttribute("email")%>'
					}
			$.ajax({
	              type: "POST",
	              url: "/WSG/community/get/byemail",
	          	  data : JSON.stringify(d2),
				  dataType : "json",
	              success: function(data, textStatus, jqXHR)
	                {
	                    if(data.code=="success"){
	                    	 var json = $.parseJSON(data.obj); 
	                    	  for(var i in json){
	                    			  var html='<div class="card horizontal" id="2">'+
		  		                    	'<div class="card-stacked"><div class="card-stacked"><div class="card-content">'+
		  		                    	'<h5>'+json[i].community_name+'</h5><br><a href="javascript:CancelRegister(\''
		  		                    			+json[i].id+'\')" class="btn ">Cancel Register</a>&nbsp;&nbsp;&nbsp;'
		  		                    			+'<a href="javascript:info(\''
		  		                    			+json[i].id+'\')" class="btn ">View Info</a></div></div></div>'
		  		                    	$('#project-card').append(html);
	                    	  }
	                    }else{
	                    }
	                },
	                error: function (jqXHR, textStatus, errorThrown)
	                {
	                    console.log(textStatus);
	                }
			})
			
		}
		
		
	})
		function enter(community_id,localdb,role,str_id){
		var kf_token= getUrlParameter('kf-token')==""||getUrlParameter('kf-token')==undefined?'<%=session.getAttribute("kftoken")%>':getUrlParameter('kf-token')
		var kfurl= getUrlParameter('kfurl')==""||getUrlParameter('kf-token')==undefined?'<%=session.getAttribute("kfURL")%>':getUrlParameter('kfurl')
		        	 window.location.href = "Community?db="+localdb
		        			 +"&role="+role
		        			 +"&str_id="+str_id
		        			 +"&community_id="+community_id
		        			 +"&kftoken="+kf_token
		        			 +"&kfurl="+kfurl;

		}
	
	
	
	function sentEmail(teacher_email,text,user_email,community){
		
		var emailJson={
				"email":teacher_email,
				"message":text+"[ from email :"+ user_email+"]",
				"title":"Request to add community  "+ community
		}
		$.ajax({
			url :  "/IIUSs/util/sendEmail",
			type : "POST",
			data : emailJson,
			success : function(data, textStatus, jqXHR) {
			}
			})
	}
	
	
	
		$("#register").click(function(){
			
		})
		
		
		function AccessCode(community_id){
			// get community info by community id
			
			$("#kfcommunity").val(community)
			$("#request-to-add-community").modal("open")
		}
		
		
		
		
		$("#btn-community-register").click(function(){
			var email =$("#kfemail").val()
			var username= $("#kfusername").val()
			var pwd = $("#kfpassword").val()
			var community=$("#kfcommunity").val()
			var kfurl= getUrlParameter('kfurl')==""?'<%=session.getAttribute("kfURL")%>':getUrlParameter('kfurl')
			$.notify('Request to add community has been sent  ', 'success');
			sentEmail(
					"jonkiky@gmail.com",
					"request to join community  "+community +" [kf username : " +username +"]   [kf_passworkd:"+ pwd+"]",
					email,
					community
			)
			
			var email =$("#kfemail").val("")
			var username= $("#kfusername").val("")
			var pwd = $("#kfpassword").val("")
			var community=$("#kfcommunity").val("")
			$("#request-to-add-community").modal("close")
		})
		
	console.log("SessionTimeOut"+<%=session.getAttribute("SessionTimeOut")%>)
	sessionTimeOut(<%=session.getAttribute("SessionTimeOut")%>)
	</script>
</body>
</html>