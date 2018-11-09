<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../validation.jsp" %>
<!DOCTYPE html>
<html>
<head>
<!--Import Google Icon Font-->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<!--Import materialize.css-->
<link type="text/css" rel="stylesheet" href="../css/materialize.css"
	media="screen,projection" />
<link type="text/css" rel="stylesheet"
	href="../css/customerize.css" media="screen,projection" />
<!--Let browser know website is optimized for mobile-->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta charset="UTF-8">
<script src="../js/jquery-3.1.0.js"></script>
<script src="../js/jquery-ui.js"></script>
<script src="../js/jquery.sessionTimeout.js"></script>
<style>
@media ( min-width : 768px) {
	.brand-logo {
		margin-left: 50px;
		margin-right: 50px;
	}
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
	width: 90%;
}



main {
	padding-left: 300px;
}

header {
	padding-left: 300px;
}

ul.side-nav.fixed li.logo {
	text-align: center;
	margin-top: 12px;
	margin-bottom: 62px;
}

nav.top-nav {
	height: 122px;
}

nav.top-nav a.brand-logo {
	line-height: 122px;
	font-size: 48px;
}

.collapsible-body {
	padding: 0px !important;
}
</style>


</head>

<body>

	<header>
		<div class="navbar-fixed">
			<nav class="top-nav blue-grey">
				<div class="container">
					<div class="nav-wrapper blue-grey row">
						<a href="#" class="brand-logo col l12">Messages</a>
					</div>
				</div>
			</nav>
		</div>


		<%@ include file="../side_menu.jsp" %>
	</header>

	<main>
	<div class="container">
	<br> <br> <br> <br>
	
	
	
  <div class="row">
    <div class="col s12">
      <ul class="tabs">
        <li class="tab col s3"><a class="active"  href="#test1">My Requests To Join</a></li>
        <li class="tab col s3"><a href="#test2"> Requests To Join My Project</a></li>
      </ul>
    </div>
    <div id="test1" class="col5 s12">
		<div class="row">
		 <table class="bordered" >
        <thead>
          <tr>
          	  <th>Index</th>
              <th>Project</th>
              <th>Status</th>
              <th>Action</th>
          </tr>
        </thead>

        <tbody id="my_request">
         
        </tbody>
      </table>
		</div>
		<div class="row">
		<div class="col s8">
		</div>
		<div class="col s4">
				<div class="row">
					<br>
					<a id="btn_joint_project" class="btn col s8 offset-s2">Join in a project</a>
				</div>
			</div>
			</div>
	</div>
    <div id="test2" class="col5 s12">

<div class="row">
		 <table class="bordered">
        <thead>
          <tr>
          	  <th>Index</th>
              <th>Project</th>
              <th>Request Sender</th>
              <th>Action</th>
          </tr>
        </thead>

        <tbody id="request_to_my">
          <tr>
            <td>Alvin</td>
            <td>Eclair</td>
            <td>$0.87</td>
          </tr>
          <tr>
            <td>Alan</td>
            <td>Jellybean</td>
            <td>$3.76</td>
          </tr>
          <tr>
            <td>Jonathan</td>
            <td>Lollipop</td>
            <td>$7.00</td>
          </tr>
        </tbody>
      </table>
		</div>
		
	</div>
	</div>
  </div>
        
	
	</div>
	</main>
<div id="modal2" class="modal modal-fixed-footer">
    <div class="modal-content" id="communities">
        
       
    </div>
    <div class="modal-footer">
        <a href="#!" class="modal-action modal-close waves-effect waves-green btn-flat ">Close</a>
    </div>
</div>


	<!--Import jQuery before materialize.js-->
	<%@ include file="../javascript.jsp" %>
	<script>
	
	function init(){
		$("#request_to_my").html("");
		$("#my_request").html("");
		var userJson = {
				"database" :'<%=session.getAttribute("localdb")%>' ,
				"token" : '<%=session.getAttribute("token")%>',
				"userId" : '<%=session.getAttribute("id")%>'
			};
			$.ajax({
				url :  "/WSG/project/join/get/byuserid",
				type : "POST",
				data : JSON.stringify(userJson),
				dataType : "json",
				success : function(data, textStatus, jqXHR) {
					if(data.code=="failure"){
						 
						$("#request_to_my").html(" <tr><td colspan=4>You have not send any request !</td></tr>")
                   }else{
                        var json = $.parseJSON(data.obj);
                        for(var i in json){
                            if (json[i].project_name!=""){
                            	var html = "<tr id='"+json[i].Id+"'><td>"+json[i].Id+"</td><td>"+json[i].project_name+"</td><td>"+json[i].status+"</td><td><a onclick=del('"+json[i].Id+"') id='btn_joint_project' class='btn col s6 '>Cancel</a></td></tr>";
                                  $("#my_request").append(html);
                            }
                        }
                   }
					}
				})
				
		
		
	}
	
	init();
	
	
	// del request by request_id
	function del(request_id){
		var requestData = {
				"database" :'<%=session.getAttribute("localdb")%>' ,
				"token" : '<%=session.getAttribute("token")%>',
				"requestId":request_id
			};
		$.ajax({
			url :  "/WSG/project/join/del",
			type : "POST",
			data : JSON.stringify(requestData),
			dataType : "json",
			success : function(data, textStatus, jqXHR) {
				 $.notify('Join request has been cancelled  .', 'success');
				 $("#"+request_id).hide()
				}
			})
			
	}
	
	// get URL's parameter By name
	function getParameterByName(name, url ) {
		
	    if (!url) url = location.href;
	    name = name.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
	    var regexS = "[\\?&]"+name+"=([^&#]*)";
	    var regex = new RegExp( regexS );
	    var results = regex.exec( url );
	    return results == null ? null : results[1];
	}
	$(".modal").modal();
	
	// click joint project funciton
	$("#btn_joint_project").click(function(){
		$("#communities").html('<h4> Click Project to request join</h4><div class="divider"></div><br>');
		
			var jsondata = {
				"database" :'<%=session.getAttribute("localdb")%>' ,
				"token" : '<%=session.getAttribute("token")%>'
			};
			$.ajax({
				url :  "/WSG/project/get/all",
				type : "POST",
				data : JSON.stringify(jsondata),
				dataType : "json",
				success : function(data, textStatus, jqXHR) {
					if(data.code=="failure"){
                        $.notify('No project in this community .', 'warn');
                   }else{
                        var json = $.parseJSON(data.obj);
                        for(var i in json){
                            if (json[i].community!=""){
                                  var html ='<div id="community'+i+'" class="collection"><a href="#" onclick=jointProject("'+json[i].id+'","community'+i+'") class="collection-item">'+json[i].title+'</a></div>';
                                  $("#communities").append(html);
                            }
                        }
                   }
					 $("#modal2").modal("open");
					}
				})
			
		
	})
	
	
	// require to joint a project
	function jointProject(projectId,div){
		var projectJson = {
				"database" :'<%=session.getAttribute("localdb")%>' ,
				"token" : '<%=session.getAttribute("token")%>',
				"userId":'<%=session.getAttribute("id")%>',
				"projectId":projectId,
				"projectName":$("#"+div).text(),
				"username":'<%=session.getAttribute("username")%>'
			};

			$.ajax({
						url :  "/WSG/project/join/add",
						type : "POST",
						data : JSON.stringify(projectJson),
						dataType : "json",
						success : function(data, textStatus, jqXHR) {
							$("#"+div).hide();
							  $.notify('Request to joint project ' +$("#"+div).text()+' has been send .', 'success');
							  init();
						}
						})
	}
	
	$(".side-nav").find(".blue-grey").removeClass('blue-grey')
	$(".side-nav").find(".active").removeClass('active')
	$(".side-nav").find(".show").removeClass('show')

	$(".in-work-space").addClass("active blue-grey lighten-2 ")
	$(".in-work-space-body").addClass("show")
	$(".in-work").addClass("active")
	
	</script>
</body>
</html>