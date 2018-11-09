<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ include file="../../validation.jsp" %>
<!DOCTYPE html>
<html>
<!--Import Google Icon Font-->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<!--Import materialize.css-->
<link type="text/css" rel="stylesheet"
	href="../../css/materialize.css" media="screen,projection" />
<link type="text/css" rel="stylesheet"
	href="../../css/customerize.css" media="screen,projection" />
	<link type="text/css" rel="stylesheet" href="../../css/jquery-ui.css"
	media="screen,projection" />
<!--Let browser know website is optimized for mobile-->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta charset="UTF-8">

<script src="../../js/jquery-3.1.0.js"></script>
<script src="../../js/jquery-ui.js"></script>
<script src="../../js/jquery.sessionTimeout.js"></script>

<style>

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
  color: black;
}

#userbox p{
text-align:left;
}


#groupbox p{
text-align:left;
}
</style>

</head>
<body>
		<header>
		<%@ include file="../../header.jsp" %>
		<%@ include file="../../side_menu_hidden.jsp" %>
	</header>
	<main>
	<div class="container">
		 <div class="row">
    <div class="col s12">
      <ul class="tabs">
        <li class="tab col s6"><a  class="active"  href="#test1">Members</a></li>
        <li class="tab col s6"><a href="#test2">Visitors</a></li>
      </ul>
    </div>
    <div id="test1" class="col s12">
    
    <div style="display: none" id="projectid">${sessionScope.projectid}</div>
		<div class="row">
			<div class="col s12" style="padding-top: 10px">
				<div class="row">
					<div class="col s12">
						<ul class="tabs tabs-fixed-width">
							<li class="tab col s3 blue-grey lighten-5"><a
								href="#members" class="blue-grey-text">Users</a></li>
							<li class="tab col s3 blue-grey lighten-5"><a
								href="#projects" class="blue-grey-text">Project groups</a></li>
							<li class="tab col s3 blue-grey lighten-5"><a href="#groups"
								class="blue-grey-text">Groups</a></li>

						</ul>
					</div>
					<div id="projects" class="col s12">
						<table class="striped centered">
							<thead>
								<tr>
									<th data-field="groupname">Group Name</th>
									<th data-field="remove">Action</th>
								</tr>
							</thead>

							<tbody id="projectgroupbody">
								
							</tbody>
						</table>
					</div>
					<div id="groups" class="col s12">
						<table class="striped centered">
							<thead>
								<tr>
									<th data-field="groupname">Group Name</th>
									<th data-field="remove">Action</th>
								</tr>
							</thead>

							<tbody id="groupbody">
								
							</tbody>
						</table>
					</div>
					<div id="members" class="col s12">
						<table class="striped centered">
							<thead>
								<tr>
									<th data-field="fn">First Name</th>
									<th data-field="ln">Last Name</th>
									<th data-field="email">Email/Gmail accounts</th>
									<th data-field="remove">Action</th>
								</tr>
							</thead>

							<tbody id="userbody">
								
							</tbody>
						</table>
					</div>



				</div>
				<div class="row">
					<div class="col s12">
						<a id="add_new" class="btn">Add User</a>
					</div>
				</div>
			</div>
		</div>
    
    
    </div>
    <div id="test2" class="col s12">Vistors</div>
  </div>
  
  
		
	</div>
	</main>

	<div id="modal1" class="modal">
		<div class="modal-content">
			<p>Jump to the thread page of the project</p>
		</div>
		<div class="modal-footer">
			<a href="#!" id="go"
				class=" modal-action modal-close waves-effect waves-green btn-flat">Go</a>
		</div>
	</div>


	<div id=groups_users_modal class="modal modal-fixed-footer">
		<div class="modal-content">
			<div class="container">
				<div class="row">
					<!-- <div class="col s4" id="projectbox">
						<h6 class="center">Projects</h6>
						<div class="divider"></div>
					</div> -->
					<div class="col s6" id="groupbox">
						<h6 class="center">Add Memeber By Groups</h6>
						<div class="divider"></div>
						
					</div>
					<div class="col s6" id="userbox">
						<h6 class="center">Add Memeber By Users</h6>
						<div class="divider"></div>
						
					</div>
				</div>
			</div>

		</div>
		<div class="modal-footer">
			<a href="#" id="add_finish"
				class="modal-action modal-close waves-effect waves-green btn-flat ">Add</a>
			<a href="#!"
				class="modal-action modal-close waves-effect waves-green btn-flat ">Cancel</a>
		</div>
	</div>


	<!--Import jQuery before materialize.js-->
		<script type="text/javascript" src="../../js/materialize.min.js"></script>
	<script src="https://d3js.org/d3.v4.min.js"></script>
		<script src="../../js/notify.js"></script>
		<script src="../../js/itm.js"></script>
	<script type="text/javascript">
	// get URL's parameter By name
	function getParameterByName(name, url ) {
	    if (!url) url = location.href;
	    name = name.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
	    var regexS = "[\\?&]"+name+"=([^&#]*)";
	    var regex = new RegExp( regexS );
	    var results = regex.exec( url );
	    return results == null ? null : results[1];
	}
	
	var project="";
	if(""!='<%=session.getAttribute("projectid")%>'){
		var project_id = <%=session.getAttribute("projectid")%>;
		var json =JSON.parse(localStorage.projects);
		project = json[project_id]
	}
	$("#page_title").html(project.title+"'s  Member Management")
		$(document).ready(function() {
							$('.modal').modal({dismissible: false});
							$('ul.tabs').tabs();
							$(".button-collapse").sideNav();
							$("#show_slide").click(function() {
								$('.button-collapse').sideNav('show');
							});
							console.log(getParameterByName("project"));
							function initUsers(){
								var json =JSON.parse(localStorage.users);
								   if(null!=json[0].id){
									   $('#userbox').append('<div style="text-align:left">');
									   tr = $('<p class="center"/>');
										tr.append('<input type="checkbox" id="ur_select_all" /> <label for="ur_select_all">Select All</label>');
										$('#userbox').append(tr);
										   for( var i in json){
											  
											   if(null!=json[i].username){
												   var tr = $('<p class="center"/>');
													tr.append('<input type="checkbox" id="user_'+ json[i].str_id +'" /> <label for="user_'+ json[i].str_id +'">'
																	+ json[i].first_name
																	+ ' '
																	+ json[i].last_name
																	+ '</label>');
													$('#userbox').append(tr);
										   }
									   }
										   $('#userbox').append('</div>');
									   
								}
							}
							
							function initProject(){
								var json =JSON.parse(localStorage.projects);
								for (var i = 0; i < json.length; i++) {
									if(null!=json[i]){
										var tr = $('<p class="center"/>');
										tr.append('<input type="checkbox" id="pj_'+ json[i].id +'" /> <label for="pj_'+ json[i].id +'">'
														+ json[i].title
														+ '</label>');
										$('#projectbox').append(tr);
									}
								}
							}
							
							function initGroup(){
								
								var jsondata = {
										"database" :'<%=session.getAttribute("localdb")%>' ,
										"token" : '<%=session.getAttribute("token")%>',
										"projectid" : <%=session.getAttribute("projectid")%>
									};
								$.ajax({
									url :  "/WSG/group/get/all",
									type : "POST",
									data : JSON.stringify(jsondata),
									dataType : "json",
									success : function(data, textStatus,
											jqXHR) {
										var json = $.parseJSON(data.obj);
										console.log(json);
										tr = $('<p class="center"/>');
										tr.append('<input type="checkbox" id="group_select_all" /> <label for="group_select_all">Select All</label>');
										$('#groupbox').append(tr);
										for (var i = 0; i < json.length; i++) {
											tr = $('<p class="center"/>');
											tr.append('<input type="checkbox" id="gp_'+ json[i].group_id +'" /> <label for="gp_'+ json[i].group_id +'">'
															+ json[i].title
															+ '</label>');
											$('#groupbox').append(tr);
										}

									},
									error : function(jqXHR, textStatus,
											errorThrown) {
										console.log(jqXHR.responseText);
									}
								});
							}
							
						
							
				
						
						
						function initProjectUser(){
							
							var projectdata = {
									"database" :'<%=session.getAttribute("localdb")%>' ,
									"token" : '<%=session.getAttribute("token")%>',
									"projectid" : <%=session.getAttribute("projectid")%>
								};

								$
										.ajax({
											url :  "/WSG/project/user/get",
											type : "POST",
											data : JSON.stringify(projectdata),
											dataType : "json",
											success : function(data, textStatus,
													jqXHR) {
												var json = $.parseJSON(data.obj);
												//console.log(json);
												if(null!=json){
													for (var i = 0; i < json.length; i++) {
														tr = $('<tr/>');
														tr.append('<td>'+ json[i].first_name+'</td>');
														tr.append('<td>'+ json[i].last_name+'</td>');
														tr.append('<td>'+ json[i].email+'</td>');
														tr.append('<td><button class="btn userremove" id="str_' + json[i].str_id + '">Remove</button></td>');
														$('#userbody').append(tr);
													}
												}
												
											},
											error : function(jqXHR, textStatus,
													errorThrown) {
												//console.log(jqXHR.responseText);
											}
										});
						}
							
						
						function initProjectGroup(){
							
							var projectdata = {
									"database" :'<%=session.getAttribute("localdb")%>' ,
									"token" : '<%=session.getAttribute("token")%>',
									"projectid" :  <%=session.getAttribute("projectid")%>
								};

							$
							.ajax({
								url :  "/WSG/project/group/get",
								type : "POST",
								data : JSON.stringify(projectdata),
								dataType : "json",
								success : function(data, textStatus,
										jqXHR) {
									var json = $.parseJSON(data.obj);
									//console.log("project group");
										if(null!=json){
										for (var i = 0; i < json.length; i++) {
										var tr = $('<tr/>');
										tr.append('<td>'+ json[i].title+'</td>');
										tr.append('<td><button class="btn groupremove" id="group_id' + json[i].group_id + '">Remove</button></td>');
										$('#groupbody').append(tr);
										}
										}
								},
								error : function(jqXHR, textStatus,
										errorThrown) {
									//console.log(jqXHR.responseText);
								}
							});
								
						}
							
						function init(){
							initUsers();
							initGroup();
							initProject();
							initProjectUser();
							initProjectGroup();
						}
							
						init()

							$("#add_finish").click(
											function() {
												if($("#userbox input:checked").length > 0)
													{
														for(var i = 0; i < $("#userbox input:checked").length; i++){
															var userdata = {
																	"database" :'<%=session.getAttribute("localdb")%>' ,
																	"token" : '<%=session.getAttribute("token")%>',
																	"projectid" :  <%=session.getAttribute("projectid")%>,
																	"usertype" : "2",
												           			"authorid" : $("#userbox input:checked")[i].id.replace("user_", ""),
												           			"userrole":"student"
												        	};

												        	$.ajax({
												                url:  "/WSG/project/member/add/byauthor",
												                type: "POST",
												                data: JSON.stringify(userdata),
												                dataType: "json",
												                success: function (data, textStatus, jqXHR) {
												                    location.reload();
												                },
												                error: function (jqXHR, textStatus, errorThrown) {
												                    console.log(jqXHR.responseText);
												                }
												            }); 
														}
														
											       }
												else{
													for(var i = 0; i < $("#groupbox input:checked").length; i++){
														   var groupdata = {
													        		"database" :'<%=session.getAttribute("localdb")%>' ,
																	"token" : '<%=session.getAttribute("token")%>',
																	"projectid" : <%=session.getAttribute("projectid")%>,
																	"usertype" : "2",
														            "groupid" :$("#groupbox input:checked")[i].id.replace("gp_", "")
														        };

													        $.ajax({
												                url:  "/WSG/project/member/add/bygroup",
												                type: "POST",
												                data: JSON.stringify(groupdata),
												                dataType: "json",
												                success: function (data, textStatus,
												                                   jqXHR) {
												                    location.reload();
												                },
												                error: function (jqXHR, textStatus,
												                                 errorThrown) {
												                    //console.log(jqXHR.responseText);
												                }
												            });
														
														
													}
												}
											}); 

							$("#add_new").click(function() {
								$('#groups_users_modal').modal('open');
							})

							$(document).delegate('.userremove', 'click',
									function() {
								
								var msg = "Are you sure to move this user out of the project? \n";
								if (confirm(msg)==true){
									console.log(this.id.replace("str_", ""));
									var userdata = {
											"database" :'<%=session.getAttribute("localdb")%>' ,
											"token" : '<%=session.getAttribute("token")%>',
											"projectid" :  <%=session.getAttribute("projectid")%>,
							            	"authorid" : this.id.replace("str_", "")
							        };

							        $
							            .ajax({
							                url:  "/WSG/project/member/del/byauthor",
							                type: "POST",
							                data: JSON.stringify(userdata),
							                dataType: "json",
							                success: function (data, textStatus, jqXHR) {
							                    //var json = $.parseJSON(data.obj);
							                    //console.log(data);
							                    location.reload();
							                },
							                error: function (jqXHR, textStatus, errorThrown) {
							                    console.log(jqXHR.responseText);
							                }
							            });  
								}
										
									});
							
							$(document).delegate('.groupremove', 'click',
									function() {
										console.log(this.id.replace("group_id", ""));
										var userdata = {
												"database" :'<%=session.getAttribute("localdb")%>' ,
												"token" : '<%=session.getAttribute("token")%>',
												"projectid" :  <%=session.getAttribute("projectid")%>,
								            "groupid" : this.id.replace("group_id", "")
								        };
	
								        $
								            .ajax({
								                url:  "/WSG/project/member/del/bygroup",
								                type: "POST",
								                data: JSON.stringify(userdata),
								                dataType: "json",
								                success: function (data, textStatus, jqXHR) {
								                    //var json = $.parseJSON(data.obj);
								                    //console.log(data);
								                    location.reload();
								                },
								                error: function (jqXHR, textStatus, errorThrown) {
								                    console.log(jqXHR.responseText);
								                }
								            });  
									});
							
							
							
							$("#group_select_all").click(function(){
								console.log(1)
							})
							
							$("#ur_select_all").click(function(){
								console.log(2)
								
                                             if($("#ur_select_all").is(':checked'))
                                             {
                                                  $("[id^=user_]").prop("checked", true)
                                             }else{
                                                  $("[id^=user_]").prop("checked", false)
                                                  }
								})
							

						});
	
	$(document).ajaxStop(function() {

		$("#group_select_all").click(function(){
			console.log(1)
			if($("#group_select_all").is(':checked'))
            {
                 $("[id^=gp_]").prop("checked", true)
            }else{
                 $("[id^=gp_]").prop("checked", false)
            }

		})
		
		$("#ur_select_all").click(function(){
			console.log(2)
			
                         if($("#ur_select_all").is(':checked'))
                         {
                              $("[id^=user_]").prop("checked", true)
                         }else{
                              $("[id^=user_]").prop("checked", false)
                              }
			})
		
	});
	
	
	
	$(".side-nav").find(".blue-grey").removeClass('blue-grey')
	$(".side-nav").find(".active").removeClass('active')
	$(".side-nav").find(".show").removeClass('show')

	$(".in-teacher-space").addClass("active blue-grey lighten-2 ")
	$(".in-teacher-space-body").addClass("show")
	$(".in-teacher").addClass("active")
	sessionTimeOut(<%=session.getAttribute("SessionTimeOut")%>)
	</script>
</body>
</html>