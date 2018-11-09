<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../validation.jsp"%>
<!DOCTYPE html>
<html>
<head>
<!--Import Google Icon Font-->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<!--Import materialize.css-->
<link type="text/css" rel="stylesheet" href="../css/materialize.css"
	media="screen,projection" />
<link type="text/css" rel="stylesheet" href="../css/customerize.css"
	media="screen,projection" />
<link type="text/css" rel="stylesheet" href="../css/jquery-ui.css"
	media="screen,projection" />
<!--Let browser know website is optimized for mobile-->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<script src="../js/jquery-3.1.0.js"></script>
<script src="../js/jquery-ui.js"></script>
<script src="../js/jquery.sessionTimeout.js"></script>
<script src="../js/itm.js"></script>
</head>

<body>

	<header>
		<nav class="  blue-grey">
			<%@ include file="../header_without_nav_bar.jsp"%>
		</nav>

	</header>

	<main>

	<div class="container" style="padding-top: 10px;">
		<div class="row">
			<div class="col s12">
				<ul class="tabs">
					<li class="tab col s4"><a class="active" href="#test1">Open
							My Projects</a></li>
					<li class="tab col s4"><a href="#test2">Browse other
							Projects</a></li>
					<li class="col s3" id="btn-new-project"><a
						href="teacherspace/setup.jsp" class="btn col s10 offset-s2">New
							project</a></li>
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


	<div id="email-modal" class="modal">
		<input type="hidden" id="email-join-project-id">
		<div class="modal-content" id="communities">
			<b>
				Request to join project :<span id="email-join-project-name"></span>
			</b>
			<div class="row">
				<div class="col s12">
					<input type="text" id="email-address"
						placeholder="type your email here">
				</div>
			</div>
			<div class="row">
				<div class="col s12">
					<textarea id="email-message" rows="8" cols="60"
						placeholder="Brief talk about your reason to join this project"></textarea>
				</div>
			</div>

		</div>
		<div class="modal-footer">
			<a href="#!" id="join-project-email-sent"
				class="modal-action modal-close waves-effect waves-green btn-flat ">Send</a>
			<a href="#!"
				class="modal-action modal-close waves-effect waves-green btn-flat ">Close</a>
		</div>
	</div>

	<!--Import jQuery before materialize.js-->

	<script type="text/javascript" src="../js/materialize.min.js"></script>
	<script src="https://d3js.org/d3.v4.min.js"></script>
	<script src="../js/notify.js"></script>
	<script src="../js/itm_local_storage.js"></script>
	<script src="../js/itm.js"></script>
	
	
	<script>

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
	
	
	 var localdb = getUrlParameter("localdb");
	 var community_id=getUrlParameter("community_id");
	 var project_id=getUrlParameter("projectid");
	 var super_token='<%=session.getAttribute("super_token")%>';
	 var token = isCrossProject?'<%=session.getAttribute("super_token")%>':'<%=session.getAttribute("token")%>';
	 var id='<%=session.getAttribute("id")%>';
	 var path =location.href
	 var isCrossProject = community_id!="<%=session.getAttribute("community_id")%>" ? true : false;
	 
	if(localdb==null||community_id==null){
		// go to err page
		location.replace("../err.jsp?message='Invlidate URL,db or community id = null'");

	}
	
	var menu_projects ='/ITM3/project/openedit.jsp?community_id="+community_id+"&localdb="+localdb+"'
	$(".menu_projects a").attr("href",menu_projects)
	var create_projects ='/ITM3/project/teacherspace/setup.jsp?community_id="+community_id+"&localdb="+localdb+"'
	$("#btn-new-project a").attr("href",menu_projects)
	
	// get community info 
	function get_community_info(){
		
		if(null!=getUrlParameter("community_id")){
			var userdata = {
					"database" : "itm3",
					"token" : token,
					"cid" : getUrlParameter("community_id")
				};
			$.ajax({
				url : "/WSG/community/byid",
				type : "POST",
				data : JSON.stringify(userdata),
				dataType : "json",
				success : function(data, textStatus, jqXHR) {
					var json = $.parseJSON(data.obj);
					if(null!=json){
						community_id=getUrlParameter("community_id")
						localdb=json[0].localdb
						community_name=json[0].community_name

						$("#page_title").html("<a href='../dashboard.jsp'>"+community_name+"</a> >&nbsp;Project")
					}else{
						
						console.log("do not find this community")
					}
					get_project_info()
				},
				error : function(jqXHR, textStatus, errorThrown) {
					setTimeout(function(){ 
						Materialize.toast('Invalid URL', 4000)
						 window.history.back();
					}, 3000);
				}
			});
		}else{
			setTimeout(function(){ 
				Materialize.toast('Invalid URL', 4000)
				 window.history.back();
			}, 3000);
		}
		
	}
	
	
	$(".button-collapse").sideNav();
	$(".in-community").hide();
	$("#show_slide").click(function() {
								$('.button-collapse').sideNav('show');
							});
	
	
	$(".modal").modal({dismissible: false});
	
	$("#btn-new-project").click(function() {
	    window.location.href = "teacherspace/setup.jsp";
	  });
	
	
	// init localstorage
	init(localdb,token,id)
	

	
	
	
	function initPage(){
		var json =JSON.parse(localStorage.projects);
		for (var i = 0; i < json.length; i++) {
			if(null!=json[i]){
				
				if(json[i].isMyProject||json[i].isMember){
					var tr = $('<div class="card horizontal" id="'+json[i].id+'"/>');
					if(json[i].logo=="@logo"||""==json[i].logo){
						json[i].logo="/res/empty.jpg"
					}
					var html = '<div class="card-image"><img style="height:220px; width:200px" src="'+json[i].logo+'"></div><div class="card-stacked"><div class="card-stacked"><div class="card-content"><h5>'
					+ json[i].title
					+ '</h5><p>Project goal: '
					+ json[i].goal
					+ '</p><p>Curriculum area: ';
					if(json[i].curriculum){
						for(var j in json[i].curriculum){
							html = html +json[i].curriculum[j].name+"&nbsp;"
						}
					}
					
					html = html+ '</p><p>Teacher(s): '
					//+ json[i].first_name + ' ' + json[i].last_name
					if(json[i].authors){
						var teachers = ""
						
						for(var j in json[i].authors){
							if(json[i].authors[j].role=="teacher"){
								teachers = teachers + json[i].authors[j].first_name+"&nbsp;"+json[i].authors[j].last_name+", "
								
							}
						}
						html = html +teachers.substring(0,teachers.length-2);
					}
					html = html+'</p><p>Grade :';
					if(json[i].grade){
						for(var j in json[i].grade){
							html = html +json[i].grade[j].title+"&nbsp;"
						}
					}
					
					if(json[i].isMyProject){
						html = html +'</p><br><br><a href="javascript:enter('+json[i].id+','+json[i].role+',\''+localdb+'\')" class="btn ">Enter</a>&nbsp;&nbsp;';
						html = html+'<a href="teacherspace/modify.jsp?community_id='+community_id+'&localdb='+localdb+'&project_id='+json[i].id+'" class="btn ">Edit</a>'
					}else{
						html = html +'</p><br><br><a href="javascript:enter('+json[i].id+','+json[i].member_role+',\''+localdb+'\')" class="btn ">Enter</a>&nbsp;&nbsp;';
					}
					
					html = html+'</div></div></div>'
					
					//<i class="material-icons">mode_edit</i><i class="material-icons">delete</i>
					tr.append(html);
					$('#project-card').append(tr);
				}else{
					var tr = $('<div class="card horizontal" id="'+json[i].id+'"/>');
					if(json[i].logo=="@logo"||""==json[i].logo){
						json[i].logo="/res/empty.jpg"
					}
					var html = '<div class="card-image"><img style="height:220px; width:200px" src="'+json[i].logo+'"></div><div class="card-stacked"><div class="card-stacked"><div class="card-content"><h5>'
					+ json[i].title
					+ '</h5><p>Project goal: '
					+ json[i].goal
					+ '</p><p>Curriculum area: ';
					if(json[i].curriculum){
						for(var j in json[i].curriculum){
							html = html +json[i].curriculum[j].name+"&nbsp;"
						}
					}
					
					html = html+ '</p><p>Teacher(s): '
					//+ json[i].first_name + ' ' + json[i].last_name
					if(json[i].authors){
						for(var j in json[i].authors){
							html = html +json[i].authors[j].first_name+"&nbsp;"+json[i].authors[j].last_name+"&nbsp; ,";
						}
					}
					html = html+'</p><p>Grade :';
					if(json[i].grade){
						for(var j in json[i].grade){
							html = html +json[i].grade[j].title+"&nbsp;"
						}
					}
					html = html +'</p><br><br><input placeholder="AccessCode" id="'+json[i].id+'_access_code" type="text"> '
					+'<a href="javascript:joinWithCode('+json[i].id+');" class="btn ">Join With Code</a>'
					+'&nbsp;&nbsp;<a href="javascript:showJointProjectModal('+json[i].id+');" class="btn ">Request To Join</a>&nbsp;&nbsp;';
					
					html = html+'</div></div></div>'
					
					//<i class="material-icons">mode_edit</i><i class="material-icons">delete</i>
					tr.append(html);
					$('#project-card-explore').append(tr);
					
				}
			}
		}
	}
	
	
	function enter(ProjectId,role,localdb){
		$.ajax({
	        url: '../SET_PROJECT_FOCUS',
	        type: 'POST',
	        data: {'projectid': ProjectId,'projectrole':role},
	        success: function (response) {
	        	window.location.href = "ourspace/dashboard.jsp?localdb=<%=session.getAttribute("localdb")%>&community_id=<%=session.getAttribute("community_id")%>&project_id="+ProjectId;
	        }
		});
		
		
	}
	
	
	function edit(ProjectId){
		
		var projectJson = {
				"database" :localdb ,
				"token" : '<%=session.getAttribute("token")%>',
				"userId":'<%=session.getAttribute("id")%>',
				"projectId":projectId,
				"projectName":"",
				"username":'<%=session.getAttribute("username")%>'
			};

			$.ajax({
						url :  "/WSG/project/join/add",
						type : "POST",
						data : JSON.stringify(projectJson),
						dataType : "json",
						success : function(data, textStatus, jqXHR) {
							  $.notify('Request to join project has been send .', 'success');
						}
						})
	}
	
	
	
	function joinWithCode(id){
		var accessCode = $("#"+id+"_access_code").val();
		if(null==accessCode||""==accessCode){ 
			$.notify('Please enter access code.', 'warn');
		}else{
			var json =JSON.parse(localStorage.projects);
			// here is a potential backdoor . all the infroamtion of project store in browser. 
			// includes  access code. 
			// one can use this bug, to join any project as wish
			// close this backdoor after finish this project
			var type =-1;
			var role=""
			switch(accessCode) {
			    case json[id].access_code_manage:
			    	type=3;
			    	role="teacher"
			        break;
			    case json[id].access_code_read_only:
			    	type=0;
			    	role="vistor"
			    	break;
			    case json[id].access_code_read_write:
			    	type=2;
			    	role="student"
			    	break;
			    default:
			    	$.notify('Access code is not accepted.', 'warn');
			}
			
			if(type!=-1){
				
				var joinWithCodeData = {
						"database" :localdb ,
						"token" : '<%=session.getAttribute("token")%>',
						"projectid":id,
						"authorid":"<%=session.getAttribute("id")%>",
						"usertype":type,
						"userrole":role
					}
					$.ajax({
						url :  "/WSG/project/member/add/byauthor",
						type : "POST",
						data : JSON.stringify(joinWithCodeData),
						dataType : "json",
						success : function(data, textStatus, jqXHR) {
							
						}
						})
						
					location.reload();
			}
			
			
		}
		
		
	}
	// require to join a project
	
	function showJointProjectModal(projectId){
		
		var email = '<%=session.getAttribute("email")%>';
	
		$("#email-join-project-id").val(projectId)
		$("#email-join-project-name").html("Join a project")

		
		if(email!=""&&null!=email&&'null'!=email){
			//show email modal
			$("#email-address").val(email)
			
		}
		var html ="I am :<br> I would like to join  project <br>"
		$("#email-message").html()
		
		$("#email-modal").modal("open")
		
	}
	
	$("#join-project-email-sent").click(function(){
		
		var pid = $("#email-join-project-id").val()
		var pName=$("#email-join-project-name").val()
		var eAddr=$("#email-address").val()
		var eMessage=$("#email-message").val()
		if(pid==""||pName==""||eAddr==""||eMessage==""){
			$.notify('Please fill out the email address and message', 'warn');
		}else{
			joinProject(pid,pName,eAddr,eMessage)
		}
		
	})
	
	
	function sentEmail(teacher_email,text,user_email,project_name){
		
		var emailJson={
				"email":teacher_email,
				"message":text+" from "+ user_email,
				"title":"Request to join project  "+ project_name
		}
		$.ajax({
			url :  "/IIUSs/util/sendEmail",
			type : "POST",
			data : emailJson,
			success : function(data, textStatus, jqXHR) {
			}
			})
		
		
	}
	function joinProject(projectId,name,email,text){
		
		// sent email to teacher
		//project/teacher/get/byid
		
		var getTeacherJson = {
				"database" :'<%=session.getAttribute("localdb")%>' ,
				"token" : '<%=session.getAttribute("token")%>',
				"pid":projectId
			};
		
		$.ajax({
			url :  "/WSG/project/teacher/get/byid",
			type : "POST",
			data : JSON.stringify(getTeacherJson),
			dataType : "json",
			success : function(data, textStatus, jqXHR) {
				
				if(data.code=="success"){
					  if($.trim(data.desc)!=$.trim("No data aviliable.")){
						  var json = $.parseJSON(data.obj);
						  for(var i in json){
							  if(json[i].email!=""||null!=json[i].email){
								  sentEmail(json[i].email,text,email,name)
							  }
						  }
							
					  }
				}
						
			}
			})
		
		
		
		
		
		
		// add information into database
		var projectJson = {
				"database" :'<%=session.getAttribute("localdb")%>' ,
				"token" : '<%=session.getAttribute("token")%>',
				"userId":'<%=session.getAttribute("id")%>',
				"projectId":projectId,
				"projectName":"",
				"username":'<%=session.getAttribute("username")%>'
			};

			$.ajax({
				url : window.location.protocol + "//"+window.location.host + "/"
						+ "WSG/project/join/add",
				type : "POST",
				data : JSON.stringify(projectJson),
				dataType : "json",
				success : function(data, textStatus, jqXHR) {
					$.notify('Request to join project has been send .',
							'success');
				}
			})
		}

		$(".side-nav").find(".blue-grey").removeClass('blue-grey')
		$(".side-nav").find(".active").removeClass('active')
		$(".side-nav").find(".show").removeClass('show')

		$(".in-teacher-space").addClass("active blue-grey lighten-2 ")
		$(".in-teacher-space-body").addClass("show")
		$(".in-teacher").addClass("active")
		
		
		console.log("SessionTimeOut"+<%=session.getAttribute("SessionTimeOut")%>)
		sessionTimeOut(1)
	</script>
</body>
</html>