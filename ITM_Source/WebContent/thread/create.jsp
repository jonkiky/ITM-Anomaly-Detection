<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ include file="../validation.jsp" %>
<%
/************validate the user session*******************/
 String current_user =" ";
 %>
<html>
<head>
<!--Import Google Icon Font-->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<link href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"
	rel="stylesheet">
<!--Import materialize.css-->
<link type="text/css" rel="stylesheet" href="../css/materialize.css"
	media="screen,projection" />
<link type="text/css" rel="stylesheet"
	href="../css/customerize.css" media="screen,projection" />
<!--Let browser know website is optimized for mobile-->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta charset="UTF-8">
<script src="../js/plotly-latest.min.js"></script>
<script src="../js/jquery-3.1.0.js"></script>
<script src="../js/jquery-ui.js"></script>
<script src="../js/jquery.sessionTimeout.js"></script>
<script src="../js/itm.js"></script>
<style>
#resizable {
	width: 150px;
	height: 150px;
	padding: 0.5em;
}

#resizable h3 {
	text-align: center;
	margin: 0;
}

@media ( min-width : 768px) {
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
	/*padding-left: 300px;*/
	
}

header {
	/*padding-left: 300px;*/
	
}

ul.side-nav.fixed li.logo {
	text-align: center;
	margin-top: 22px;
	margin-bottom: 62px;
	line-height: 64px;
}

.brand-logo {
	
}

nav.top-nav {
	
}

nav.top-nav a.brand-logo {
	font-size: 36px;
}
.btn-confirm{
 	width:80px;
 	padding:0px;
 }
 .blk_1{
 	width:90%;
 	display:inline-block;
 	padding-left:20px;
}
.blk_2{
	width:50%;
	display:inline-block;
	padding-left:20px;
}
.loading{
	float:left;
	width:100%;
	text-align:center;
	font-size:13px;
	line-height: 30px;
	height: 30px;
    margin: 5px 0px 5px 0px;
}
</style>


</head>

<body>

	<header>
			<nav  class="  blue-grey">
			<%@ include file="../header.jsp" %>
			<%@ include file="../side_menu_hidden.jsp" %>
			</nav>
	</header>

	<main> 
	<br><br>
		<div class="container">
			<div class="row">
			  <input placeholder="Title" id="title" type="text" class="validate">
			</div>
			<div class="row">
			  <label>Co-Author</label>	
			  </div>
			<div class="row">
				 <select multiple id="select-user">
						    	<option value="-1" id="ur_select_all" ></option>
						    </select>
						 
			</div>
			<div class="row">
			  <label>Copy To KF5 View</label>	
			  </div>
			<div class="row">
				 <select multiple id="selected-views">
						    	<option value="-1" id="ur_select_all" ></option>
						    </select>
						 
			</div>
			<div class="row">
				<textarea id="content">Hello, World!</textarea>
			</div>
			
			<div class="row">
				<div class="input-field  col s2 ">
					<a id="btn-save" class="btn">Save</a>
				</div> 

			</div>
			
		</div>
	</main>
	<br><br><br><br><br><br>

	<!--Import jQuery before materialize.js-->
	<script src="../js/notify.js"></script>
	<script type="text/javascript" src="../js/materialize.min.js"></script>
	<script src="https://d3js.org/d3.v4.min.js"></script>
	<script src='../js/tinymce/tinymce.min.js'></script>
	<script>
	
	
	$("#btn-save").click(function(){
		 var nid ='<%=session.getAttribute("projectid")%>'+'<%=session.getAttribute("threadid")%>'+Math.floor((Math.random() * 10000) + 1).toString()
		 var json = {
				 "database" :'<%=session.getAttribute("localdb")%>' ,
				 "token" : '<%=session.getAttribute("token")%>',
				 "title":$("#title").val(),
				 "noteid":nid,
				 "content":$("#content").val().replace(/'/g,"\\\'").replace(/"/g,"\\\""),
				 "ctime":new Date(),
				 "offset":"-1"
		 }
		 $.ajax({
				url :  "/WSG/note/add",
				type : "POST",
				data : JSON.stringify(json),
				dataType : "json",
				success : function(data, textStatus,
						jqXHR) {
					 if(data.code=="success"){
						 console.log(1)
						
						 // view add
						 addViewNoter(nid)
						 // co-author
						 addCoAuthor(nid)
						 //thread note
						  addThreadNote(nid)
					 }
				}})
	})
	
	
	function addThreadNote(nid){
		 var json = {
				 "database" :'<%=session.getAttribute("localdb")%>' ,
				 "token" : '<%=session.getAttribute("token")%>',
				 "projectid":<%=session.getAttribute("projectid")%>,
				 "noteid":nid,
				 "threadid":<%=session.getAttribute("threadid")%>,
				 "ctime":new Date()
		 }
		$.ajax({
			url :  "/WSG/thread/note/add",
			type : "POST",
			data : JSON.stringify(json),
			dataType : "json",
			success : function(data, textStatus,
					jqXHR) {
				 if(data.code=="success"){
					 console.log(1)
				 }
			}})
	}
	

	function addCoAuthor(nid){
		var json = {
				 "database" :'<%=session.getAttribute("localdb")%>' ,
				 "token" : '<%=session.getAttribute("token")%>',
				 "authorid":'<%=session.getAttribute("id")%>',
				 "noteid":nid
		 }
		$.ajax({
			url :  "/WSG/note/author/add",
			type : "POST",
			data : JSON.stringify(json),
			dataType : "json",
			success : function(data, textStatus,
					jqXHR) {
				 if(data.code=="success"){
					 console.log(1)
				 }
			}
		})
		
		$('#select-user input:checked').each(function(){
			var json2 = {
					 "database" :'<%=session.getAttribute("localdb")%>' ,
					 "token" : '<%=session.getAttribute("token")%>',
					 "authorid":$(this).attr('value'),
					 "noteid":nid
			 }
			$.ajax({
				url :  "/WSG/note/author/add",
				type : "POST",
				data : JSON.stringify(json2),
				dataType : "json",
				success : function(data, textStatus,
						jqXHR) {
					 if(data.code=="success"){
						 console.log(1)
					 }
				}
			})
		
		})
		
	}

	function addViewNote (nid){
		$('#selected-views input:checked').each(function(){
			var json = {
					 "database" :'<%=session.getAttribute("localdb")%>' ,
					 "token" : '<%=session.getAttribute("token")%>',
					 "viewid":$(this).attr('value'),
					 "noteid":nid
			 }
			$.ajax({
				url :  "/WSG/view_note/add",
				type : "POST",
				data : JSON.stringify(json),
				dataType : "json",
				success : function(data, textStatus,
						jqXHR) {
					 if(data.code=="success"){
						 console.log(1)
					 }
				}
			})
		
		})
	}
	
	$(document).ajaxStop(function() {
	
		  $.notify('Creat note success', 'success');
	})
		
		
	tinymce.init({
	    selector: '#content'
	  });
	
	
	$(".button-collapse").sideNav();
	$(".in-community").hide();
	$("#show_slide").click(function() {
		$('.button-collapse').sideNav('show');
	});
	$(".modal").modal();
	$("#page_title").html("New Note")
	
	 $('.datepicker').pickadate({
		    selectMonths: true, // Creates a dropdown to control month
		    selectYears: 15 // Creates a dropdown of 15 years to control year
		  });
	
	
	
	function init(){
		

		initUser()
		
		initViews()
		// init 
		$('select').material_select();
		
	
		
	}
	init()
	
	function initViews(){
		var jsondata = {
				"database" :'<%=session.getAttribute("localdb")%>' ,
				"token" : '<%=session.getAttribute("token")%>'
		};
		$.ajax({
			url :  "/WSG/view/get/all",
			type : "POST",
			data : JSON.stringify(jsondata),
			dataType : "json",
			success : function(data, textStatus, jqXHR) {
				if(data.code=="success"){
                	 var json =data.obj;
                	 if($.trim(json)!="No data aviliable."){
	            			
                		 var d = $.parseJSON(json); 
                		  for( var i in d){
   						   $("#selected-views").append(
   						   $("<option id='vid_"+d[i].view_id+"'></option>")
   					        .attr("value",d[i].view_id)
   					        .text(d[i].title)
   					        )
   					   }
   					   $("#selected-views").trigger('contentChanged');
                	 }
				}
			}
		})
	}
	function initUser(){
			var d =JSON.parse(localStorage.users);
       		  for( var i in d){
					   $("#select-user").append(
					   $("<option id='user_"+d[i].str_id+"'></option>")
				        .attr("value",d[i].str_id)
				        .text(d[i].first_name+"　"+d[i].last_name)
				        )
				   }
				   $("#select-user").trigger('contentChanged');
       	 }
	
		
  $('select').on('contentChanged', function() {
			 // re-initialize (update)
				 $(this).material_select();
		});
	
	
	
		$(document).ready(function() {
			
			
			
		});
	
	
	console.log('localdb:<%=session.getAttribute("localdb")%>')
	console.log('token:<%=session.getAttribute("token")%>')
	console.log('community:<%=session.getAttribute("community")%>')
	console.log('c_id:<%=session.getAttribute("community_id")%>')
	console.log('type:<%=session.getAttribute("role")%>')
	console.log('urname:<%=session.getAttribute("username")%>')
	console.log('id:<%=session.getAttribute("id")%>')
	console.log('itmdb:<%=session.getAttribute("ITMDatabase")%>')
	console.log('domain:<%=session.getAttribute("domain")%>')
	console.log('token:<%=session.getAttribute("token")%>')
	console.log('school:<%=session.getAttribute("school")%>')
	console.log('country:<%=session.getAttribute("country")%>')
	console.log('city:<%=session.getAttribute("city")%>')
	console.log('projectid:<%=session.getAttribute("projectid")%>')
		console.log('threadid:<%=session.getAttribute("threadid")%>')
	console.log('threadname:<%=session.getAttribute("threadname")%>')
	
	sessionTimeOut(<%=session.getAttribute("SessionTimeOut")%>)	
	</script>
</body>
</html>