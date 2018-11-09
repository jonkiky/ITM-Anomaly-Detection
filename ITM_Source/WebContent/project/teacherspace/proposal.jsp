	<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ include file="../../validation.jsp" %>
<!DOCTYPE html>
<html>
<head>
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
<script type="text/javascript" src="../../js/materialize.min.js"></script>
<script src="../../js/itm.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta charset="UTF-8">

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


.tabs .indicator {
	color: black;
	background-color: black;
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

.collapsible-body {
	padding: 0px !important;
}
s
</style>


</head>

<body>

		<header>
		<%@ include file="../../header.jsp" %>
		<%@ include file="../../side_menu_hidden.jsp" %>
	</header>

	<main>
	<div class="container">
			<div class="row"></div>
			<div><b><font size="3">Proposals of new wondering areas</font></b>  </div>
			<div class="row">
			<div class="col s12" >
				<div
					style=" border: solid 5px; border-color: #78909c;">
					<table class="bordered highlight">
						<thead >
							<tr>
								<th>title</th>
								<th>date</th>
								<th>proposed by</th>
								<th>overarching questions / why important</th>
								<th>approval status</th>
								<th>action</th>
							</tr>

						</thead>
						<tbody id="wabox"></tbody>
					</table>
				</div>
				</div>
			</div>	
			<div>	<b><font size="3">Buddy Project Invitation</font></b>  </div>
			<div class="row">
			<div class="col s12" >
				<div style=" border: solid 5px; border-color: #78909c;">
					 <div class="row">
   					 <div class="col s12">
					 <ul class="tabs">
        				<li class="tab col s6 blue-grey lighten-5"><a href="#test1" class="active blue-grey-text">Invitation</a></li>
        				<li class="tab col s6 blue-grey lighten-5"><a  href="#test2" class="blue-grey-text">My Invitation</a></li>
        			</ul>
        			</div>
        			<div id="test2" class="col s12">
					<table class="striped">
							<thead>
							<tr>
								<th >Project Name</th>
                                        <th >School</th>
                                        <th >City</th>
                                        <th >Country</th>
                                        <th >Grade level</th>
                                        <th >Curriculum area</th>
                                         <th >Teacher</th>
                                         <th >Message</th>
                                         <th >Status</th>
							</tr>
						</thead>

						<tbody id="connected_buddy_projects"></tbody>
					</table>
					</div>
    				<div id="test1" class="col s12">
    				<table class="striped">
							<thead>
							<tr>
								<th >Project Name</th>
                                        <th >School</th>
                                        <th >City</th>
                                        <th >Country</th>
                                        <th >Grade level</th>
                                        <th >Curriculum area</th>
                                         <th >Teacher</th>
                                         <th >Message</th>
                                         <th >Status</th>
                                        <th >Actions</th>
							</tr>
						</thead>

						<tbody id="connected_buddy_projects2"></tbody>
					</table>
    				</div>
					
					</div>
				</div>
			</div>
		</div>
			<div><b><font size="3">Proposals of Super Talk topics</font></b>  </div>
			<div class="row">
			<div class="col s12" >
				<div style=" border: solid 5px; border-color: #78909c;">
					<table class="striped">
						<thead >
							<tr>
								<th>title</th>
								<th>date</th>
								<th>proposed by</th>
								<th>column for each Big Question proposal property</th>
								<th>approval status</th>
							</tr>
						</thead>
							<tbody id="super-talk-box"></tbody>
					</table>
				</div>
			</div>
		</div>
		
			
	</div>
	</main>

	<div id="wondering_modal" class="modal">
	<input id="wondering_message_id" type="hidden" >
		<div class="modal-content">
			
				 <fieldset>
					  <legend>Wondering Area Message</legend>
					<div id="wondering_area_message"></div>
					 </fieldset>
			<p></p>
			<textarea rows="10" cols="50" id="input_wondering_area" placeholder="type here.."></textarea>
		</div>
		<div class="modal-footer">
			<a href="#!" 
				class=" modal-action modal-close waves-effect waves-green btn-flat">Cancel</a>
			<a  id="btn_wondering_area_message"
				class=" modal-action  waves-effect waves-green btn-flat">Sent</a>
		</div>
	</div>
	
	
	
	<div id="super_talk_modal" class="modal">
	<input id="super_talk_id" type="hidden" >
			<div class="modal-content">
			
				 <fieldset>
					  <legend>Super Talk Message</legend>
					<div id="super_talk_message"></div>
					 </fieldset>
					 
				
				<p></p>
				<textarea rows="10" cols="50" id="input_super_talk" placeholder="type here.."></textarea>
			</div>
			<div class="modal-footer">
				<a href="#!" 
					class=" modal-action modal-close waves-effect waves-green btn-flat">Cancel</a>
				<a href="#!" id="btn_super_talk_message"
					class=" modal-action  waves-effect waves-green btn-flat">Sent</a>
			</div>
		</div>


		<!--Import jQuery before materialize.js-->
	<script type="text/javascript" src="../../js/materialize.min.js"></script>
	<script src="https://d3js.org/d3.v4.min.js"></script>
		<script src="../../js/notify.js"></script>
		<script src="../../js/itm.js"></script>
	<script type="text/javascript">
        var localdb = getUrlParameter("localdb");
	$(".modal").modal();
	
	
	  $(document).ready(function(){
		    $('ul.tabs').tabs();
		    
		    $("#btn_wondering_area_message").click(function(){
				var passJson={
					"database" :'<%=session.getAttribute("localdb")%>' ,
					"token" : '<%=session.getAttribute("token")%>',
					"areaid":$("#wondering_message_id").val(),
					"areaMessage":$("#input_wondering_area").val().replace(/'/g,"\\\'").replace(/"/g,"\\\""),
					"authorId":'<%=session.getAttribute("id")%>',
					"fname":$('<%=session.getAttribute("fname")%>').replace(/'/g,"\\\'").replace(/"/g,"\\\""),
					"lname":$('<%=session.getAttribute("lname")%>').replace(/'/g,"\\\'").replace(/"/g,"\\\""),
					"createtime":new Date()
				}
			
			$.ajax({
				url :  "/WSG/wondering_area/message/add",
				type : "POST",
				data : JSON.stringify(passJson),
				dataType : "json",
				success : function(data, textStatus, jqXHR) {
					 Materialize.toast('Message has been sented', 4000);
					 $("#wondering_modal").modal("close")
				}}) 
				}
		    )
			
			
			$("#btn_super_talk_message").click(function(){
				var passData={
						"database":"itm3",
						"token" : '<%=session.getAttribute("token")%>',
						"sid":$("#super_talk_id").val(),
						"authorid": '<%=session.getAttribute("id")%>',
						"communityid": '<%=session.getAttribute("community_id")%>',
						"createtime":new Date(),
						"supertalkMessage":$("#input_super_talk").val().replace(/'/g,"\\\'").replace(/"/g,"\\\""),
						"fname":$('<%=session.getAttribute("fname")%>').replace(/'/g,"\\\'").replace(/"/g,"\\\""),
						"lname":$('<%=session.getAttribute("lname")%>').replace(/'/g,"\\\'").replace(/"/g,"\\\""),
						"uname":$('<%=session.getAttribute("username")%>').replace(/'/g,"\\\'").replace(/"/g,"\\\""),
						"localdb":'<%=session.getAttribute("localdb")%>' 	
				}
				
				
				$.ajax({
					url :  "/WSG/supertalk/message/add",
					type : "POST",
					data : JSON.stringify(passData  
							),
					dataType : "json",
					success : function(data, textStatus, jqXHR) {
						 Materialize.toast('Message has been sented', 4000);
						 $("#super_talk_modal").modal("close")
					}}) 
				
				
			})
			
			
		  });
		        
	 function supertalk_SentMessage(id){
		 
		 $("#super_talk_id").val(id);
		// get message
			var passData = {
				"database" :'itm3' ,
				"token" : '<%=session.getAttribute("token")%>',
				"sid" : id
			}
			
			$.ajax({
				url :  "/WSG/supertalk/message/get",
				type : "POST",
				data : JSON.stringify(passData),
				dataType : "json",
				success : function(data) {
					$("#super_talk_message").empty().html("")
					if(null!=data.obj){
						if(null!=data.obj[0]){
							var json = $.parseJSON(data.obj);
							if(json!=null){
								for(var c in json){
									$("#super_talk_message").append("<b>"+json[c].f_name+"  "+json[c].l_name+":</b> <br>"+json[c].message+"<br>")
								}
							}
						}
					}
					
					$("#super_talk_modal").modal("open")
					}
				});
			
		 
	 }
	 
	 
	function invitationAccept(id,from_project,from_project_name){
		var json = {
	      		"database" :"itm3" ,
				"token" : '<%=session.getAttribute("token")%>',
				"superid":id,
//				"superstatus":'pending'
				"superstatus":'accepted'
				};
		
		$.ajax({
			url :  "/WSG/project_buddy_project/status/update",
			type : "POST",
			data : JSON.stringify(json),
			dataType : "json",
			success : function(data, textStatus, jqXHR) {

				//-------------------------
                var json = {
                    "database" :localdb ,
                    "token" : '<%=session.getAttribute("token")%>'
                };
                $.ajax({
                    url :  "/WSG/wondering_area/count",
                    type : "POST",
                    data : JSON.stringify(json),
                    dataType : "json",
                    success : function(data, textStatus, jqXHR) {
                        if(data.code=="success"){
                                var json = $.parseJSON(data.obj);
                                console.log("invites fo from ",json);
                                const result = json.filter(function(item){
                                    return item.project_id == from_project;
								});
                                console.log(result);
                                // If Result == 0 , Create New Area & Reg Both the projects
								if(result.length == 0){
								    //Creating New Area
									console.log("Creating New Area");
//									========
                                        wfdata = {
                                            "database" : localdb,
                                            "token" : '<%=session.getAttribute("token")%>',
                                            "wname" : from_project_name+"'s Shared Area",
                                            "logo" : "@logo",
                                            "keywords" : "",
                                            "wstatus" : "accepted",
                                            "overarchingquestions" : "",
                                            "whyimportant" : "",
                                            "authorid" :'<%=session.getAttribute("id")%>',
                                            "wcreatetime":new Date(),
                                            "message" : "",
                                            "project_id":0
                                        };
                                        $.ajax({
                                            url :  "/WSG/wondering_area/add",
                                            type : "POST",
                                            data : JSON.stringify(wfdata),
                                            dataType : "json",
                                            success : function(data,textStatus,jqXHR) {
                                                if(data.code=="success"){
                                                    if($.trim(data.desc)!=$.trim("No data aviliable.")){
                                                        var wid=data.obj[0]["GENERATED_KEY"];
                                                        console.log("GENERATED_KEY",wid);
                                                        //add wid with project
                                                        var json = {
                                                            "database" :localdb ,
                                                            "token" : '<%=session.getAttribute("token")%>',
                                                            "areaid" : parseInt(wid)
                                                        };

                                                        json['pid'] = from_project;
                                                        $.ajax({
                                                            url :  "/WSG/project/wondering/add",
                                                            type : "POST",
                                                            data : JSON.stringify(json),
                                                            dataType : "json",
                                                            success : function(data, textStatus, jqXHR) {
                                                                console.log("Added to "+ from_project);

                                                            }
                                                        })

                                                        project_id =  <%=session.getAttribute("projectid")%>;
                                                        json['pid'] = project_id
                                                        $.ajax({
                                                            url :  "/WSG/project/wondering/add",
                                                            type : "POST",
                                                            data : JSON.stringify(json),
                                                            dataType : "json",
                                                            success : function(data, textStatus, jqXHR) {
                                                                console.log("Added to "+ project_id);
                                                            }
                                                        })
                                                    }
                                                }
                                            }
                                        });

//									========
								}
								else{
                                    //add wid with project
                                    result.forEach(function(item){
                                    var json = {
                                        "database" :localdb ,
                                        "token" : '<%=session.getAttribute("token")%>',
                                        "areaid" : parseInt(item.area_id)
                                    };
                                    project_id =  <%=session.getAttribute("projectid")%>;
                                    json['pid'] = project_id
                                    $.ajax({
                                        url :  "/WSG/project/wondering/add",
                                        type : "POST",
                                        data : JSON.stringify(json),
                                        dataType : "json",
                                        success : function(data, textStatus, jqXHR) {
                                            console.log("Added to "+ project_id);
                                        }
                                    })
                                    })
								}
                            }
                            else{
                                //Creating New Area
                                console.log("Creating New Area");
//									========
                                wfdata = {
                                    "database" : localdb,
                                    "token" : '<%=session.getAttribute("token")%>',
                                    "wname" : from_project_name+"'s Shared Area",
                                    "logo" : "@logo",
                                    "keywords" : "",
                                    "wstatus" : "accepted",
                                    "overarchingquestions" : "",
                                    "whyimportant" : "",
                                    "authorid" :'<%=session.getAttribute("id")%>',
                                    "wcreatetime":new Date(),
                                    "message" : "",
                                    "project_id":0
                                };
                                $.ajax({
                                    url :  "/WSG/wondering_area/add",
                                    type : "POST",
                                    data : JSON.stringify(wfdata),
                                    dataType : "json",
                                    success : function(data,textStatus,jqXHR) {
                                        if(data.code=="success"){
                                            if($.trim(data.desc)!=$.trim("No data aviliable.")){
                                                var wid=data.obj[0]["GENERATED_KEY"];
                                                console.log("GENERATED_KEY",wid);
                                                //add wid with project
                                                var json = {
                                                    "database" :localdb ,
                                                    "token" : '<%=session.getAttribute("token")%>',
                                                    "areaid" : parseInt(wid)
                                                };

                                                json['pid'] = from_project;
                                                $.ajax({
                                                    url :  "/WSG/project/wondering/add",
                                                    type : "POST",
                                                    data : JSON.stringify(json),
                                                    dataType : "json",
                                                    success : function(data, textStatus, jqXHR) {
                                                        console.log("Added to "+ from_project);

                                                    }
                                                })

                                                project_id =  <%=session.getAttribute("projectid")%>;
                                                json['pid'] = project_id
                                                $.ajax({
                                                    url :  "/WSG/project/wondering/add",
                                                    type : "POST",
                                                    data : JSON.stringify(json),
                                                    dataType : "json",
                                                    success : function(data, textStatus, jqXHR) {
                                                        console.log("Added to "+ project_id);
                                                    }
                                                })
                                            }
                                        }
//                                                location.reload();
                                    }
                                });
							}

                    }})


				initInvitation()
			}})
			
		
	}
	
	function invitationDecline(id){
		var json = {
	      			"database" :"itm3" ,
				"token" : '<%=session.getAttribute("token")%>',
				"superid":id,
				"superstatus":'decline'
				};

		$.ajax({
			url :  "/WSG/project_buddy_project/status/update",
			type : "POST",
			data : JSON.stringify(json),
			dataType : "json",
			success : function(data, textStatus, jqXHR) {
				initInvitation()
			}})
	}
	
	//get connected buddy project
	function initInvitation(){
		$("#connected_buddy_projects").html("");
		var c_id = '<%=session.getAttribute("community_id")%>'
		var project_id = <%=session.getAttribute("projectid")%>
		$("#connected_buddy_projects").empty().html("");
		$("#connected_buddy_projects2").empty().html("");
		if(c_id!=""&&project_id!=""){
	 	      	var json = {
	 	      			"database" :"itm3" ,
						"token" : '<%=session.getAttribute("token")%>',
						"pid":<%=session.getAttribute("projectid")%>,
						"cid":'<%=session.getAttribute("community_id")%>'
						};
					$.ajax({
						url :  "/WSG/my_buddy_project/invitation/get",
						type : "POST",
						data : JSON.stringify(json),
						dataType : "json",
						success : function(data, textStatus, jqXHR) {
							if(data.code=="success"){
								 var html =""
								  if($.trim(data.desc)!=$.trim("No data aviliable.")){
									  var json = $.parseJSON(data.obj);
									  console.log("buddy_project/invitation",json);
									  for(var i in json){
										  if(json[i].project_id!=project_id||json[i].community!=c_id){
											  html=html+"<tr><td>"+json[i].project_title+"</td>"
											  +"<td>"+json[i].school+"</td>"
											  +"<td>"+json[i].city+"</td>"
											  +"<td>"+json[i].country+"</td>"
											  +"<td>"+json[i].grade_level+"</td>"
											  +"<td>"+json[i].curriculum+"</td>"
											  +"<td>"+json[i].teachers+"</td>"
											  +"<td>"+json[i].message+"</td>"
											  +"<td>"+json[i].status+"</td>"
										  		+"</tr>"
										  }
									  }
									  $("#connected_buddy_projects").append(html);
								  }
								  }
						}})
						
						$.ajax({
						url :  "/WSG/buddy_project/invitation",
						type : "POST",
						data : JSON.stringify(json),
						dataType : "json",
						success : function(data, textStatus, jqXHR) {
							 var html =""
							if(data.code=="success"){
								  if($.trim(data.desc)!=$.trim("No data aviliable.")){
									  var json = $.parseJSON(data.obj);
									  console.log("invites",json);
									  for(var i in json){
										  if(json[i].project_id!=project_id||json[i].community!=c_id){
											  html=html+"<tr><td>"+json[i].project_title+"</td>"
											  +"<td>"+json[i].school+"</td>"
											  +"<td>"+json[i].city+"</td>"
											  +"<td>"+json[i].country+"</td>"
											  +"<td>"+json[i].grade_level+"</td>"
											  +"<td>"+json[i].curriculum+"</td>"
											  +"<td>"+json[i].teachers+"</td>"
											  +"<td>"+json[i].message+"</td>"
											  +"<td>"+json[i].status+"</td>"
											  if(json[i].status.toLowerCase()=="pending"){
												  html=html+"<td><div onclick=\"invitationAccept('"+json[i].id+"','"+ json[i].project_id+"','"+ json[i].project_title+"')\" class='btn'>Accept</div>"
												  +"&nbsp;&nbsp;<div onclick=\"invitationDecline('"+json[i].id+"')\" class='btn'>Dcline</div></td>"
											  		+"</tr>"
												  
											  }
											  if(json[i].status.toLowerCase()=="accepted"){
												  html=html+"<td>"
												  +"&nbsp;&nbsp;<div onclick=\"invitationDecline('"+json[i].id+"')\" class='btn'>Dcline</div></td>"
												  +"</td></tr>"										  
																							  }
											  if(json[i].status.toLowerCase()=="decline"){
												  html=html+"<td><div onclick=\"invitationAccept('"+json[i].id+"','"+ json[i].project_id+"','"+ json[i].project_title+"')\" class='btn'>Accept</div>"
												  +"&nbsp;&nbsp;</td>"
											  	  +"</tr>"
											  		html=html+"<td></td></tr>"		
												}			
											  
										  }
									  }
									  $("#connected_buddy_projects2").append(html);
								  }
								  }
						}})
		}
		
	}
	
		$(document).ready(
						function() {
							
							var project;
							if(""!='<%=session.getAttribute("projectid")%>'){
								var project_id = <%=session.getAttribute("projectid")%>;
								var json =JSON.parse(localStorage.projects);
								project = json[project_id]
							}
							$("#page_title").html(project.title+"'s  Message Center")
							$(".button-collapse").sideNav();
							$("#show_slide").click(function() {
								$('.button-collapse').sideNav('show');
							});

							 
							$(document).delegate(
									'.accept',
									'click',
									function acceptWA() {
										console.log($(this)[0].id
												.replace(
														"wa_accept",
														""));

										var wadata = {
												"database" :'<%=session.getAttribute("localdb")%>' ,
												"token" : '<%=session.getAttribute("token")%>',
											"wstatus" : "accepted",
											"wid" : $(this)[0].id
													.replace(
															"wa_accept",
															"")

										};

										$
												.ajax({
													url :  "/WSG/wondering_area/status/update",
													type : "POST",
													data : JSON
															.stringify(wadata),
													dataType : "json",
													success : function() {
														$('#wabox').empty().html("");
														initWonderingArea()

													},
													error : function(
															jqXHR,
															textStatus,
															errorThrown) {
														console
																.log(jqXHR.responseText);
													}
												});

										//console.log($(".badge").text());
										$(".badge").text(
												$(".badge").text() - 1);
									});

							$(document).delegate(
											'.decline',
											'click',
											function() {

												var wadata = {
														"database" :'<%=session.getAttribute("localdb")%>' ,
														"token" : '<%=session.getAttribute("token")%>',
														"wstatus" : "decline",
														"wid" : $(this)[0].id.replace("wa_decline","")

												};

												$.ajax({
															url :  "/WSG/wondering_area/update/status",
															type : "POST",
															data : JSON.stringify(wadata),
															dataType : "json",
															success : function() {
																$('#wabox').empty().html("");
																initWonderingArea()

															},
															error : function(
																	jqXHR,
																	textStatus,
																	errorThrown) {
																console
																		.log(jqXHR.responseText);
															}
														});

												//console.log($(".badge").text());
												$(".badge").text(
														$(".badge").text() - 1);
											});
							$(document).delegate(
									'.message',
									'click',
									function() {
										
										// get message
										var wadata = {
											"database" :'<%=session.getAttribute("localdb")%>' ,
											"token" : '<%=session.getAttribute("token")%>',
											"areaid" : parseInt($(this)[0].id.replace("wa_sent_message",""))
										}
										
										$("#wondering_message_id").val($(this)[0].id.replace("wa_sent_message",""))
										$.ajax({
											url :  "/WSG/wondering_area/message/get",
											type : "POST",
											data : JSON.stringify(wadata),
											dataType : "json",
											success : function(data) {
												$("#wondering_area_message").empty().html("")
												if(null!=data.obj){
													if(null!=data.obj[0]){
														var json = $.parseJSON(data.obj);
														if(json!=null){
															for(var c in json){
																$("#wondering_area_message").append("<b>"+json[c].f_name+"  "+json[c].l_name+":</b> <br>"+json[c].message+"<br>")
															}
														}
													}
												}
												$("#wondering_modal").modal("open")
												}
											});
										
										
									});

							$('.collection').delegate('a', 'click', function() {
								window.location.href = "../thread/open.html";
							});

						function init(){
							initWonderingArea()
							initSuperTalk()
							initInvitation()
						}
						init()
						
						
					
						function initWonderingArea(){
							var userdata = {
									"database" :'<%=session.getAttribute("localdb")%>' ,
									"token" : '<%=session.getAttribute("token")%>',
									"pid":<%=session.getAttribute("projectid")%>
							};

							$.ajax({
										url :  "/WSG/wondering_area/get/byprojectid",
										type : "POST",
										data : JSON.stringify(userdata),
										dataType : "json",
										success : function(data, textStatus,
												jqXHR) {
											var json = $.parseJSON(data.obj);
											console.log(json);
											for (var i = 0; i < json.length; i++) {
												var tr = '<tr><td>'
														+ json[i].name
														+ '</td><td>'
														+ json[i].create_time.substring(0,json[i].create_time.lastIndexOf("-")+3)
														+ '</td><td>'
														+ json[i].first_name
														+ " "
														+ json[i].last_name
														+ '</td><td>'
														+ json[i].overarching_questions + " / "
														+ json[i].why_important
														+ '</td><td>'
														+ json[i].status
																
														if(json[i].status.toLowerCase() =="pending"){
															tr =tr + '</td><td><button id="wa_accept'+json[i].id
															+'" class="btn accept" style="text-align: center;">Accept</button>'
															+'<button id="wa_decline'+json[i].id
															+'" class="btn decline" style="text-align: center; margin-left: 20px">Decline</button><button id="wa_sent_message'
															+json[i].id+'" class="btn message" style=" margin-left: 20px;">Message</button></td></tr>';
														}
														if(json[i].status.toLowerCase() =="accepted"){
															tr =tr + '</td><td>'
															+'<button id="wa_decline'+json[i].id
															+'" class="btn decline" style="text-align: center; margin-left: 20px">Decline</button><button id="wa_sent_message'
															+json[i].id+'" class="btn message" style=" margin-left: 20px;">Message</button></td></tr>';
														}
														if(json[i].status.toLowerCase() =="decline"){
															tr =tr + '</td><td><button id="wa_accept'+json[i].id
															+'" class="btn accept" style="text-align: center;">Accept</button>'
															+'<button id="wa_sent_message'
															+json[i].id+'" class="btn message" style=" margin-left: 20px;">Message</button></td></tr>';
														}
														
													$('#wabox').append(tr);
											}
										},
										error : function(jqXHR, textStatus,
												errorThrown) {
											console.log(jqXHR.responseText);
										}
									});
							
						}
						
		
	

		
		
		});
		
		function superTalkStatus(id,status){
			if(status==1){
				// accept
				var userdata = {
						"database" :'super_talk' ,
						"token" : '<%=session.getAttribute("super_token")%>',
									"supertalk_status":"accepted",
									"sid":id
							};

							$.ajax({
										url :  "/WSG/supertalk/status/update",
										type : "POST",
										data : JSON.stringify(userdata),
										dataType : "json"
										})
				sleepFor(1000); 					
				initSuperTalk()
				
			}else{
				var userdata = {
						"database" :'super_talk' ,
						"token" : '<%=session.getAttribute("super_token")%>',
						"supertalk_status":"decline",
						"sid":id
				};

				$.ajax({
							url :  "/WSG/supertalk/status/update",
							type : "POST",
							data : JSON.stringify(userdata),
							dataType : "json"
							})
				// decline
				sleepFor(1000); 
				initSuperTalk()
			}
			
			
		}
		
		function initSuperTalk(){
			$('#super-talk-box').empty().html("")
			var userdata = {
					"database" :'super_talk' ,
					"token" : '<%=session.getAttribute("super_token")%>',
			};

			$.ajax({
				url :  "/WSG/supertalk/get/all",
				type : "POST",
				data : JSON.stringify(userdata),
				dataType : "json",
				success : function(data, textStatus,
						jqXHR) {
					var json = $.parseJSON(data.obj);
					console.log(json);
					if(json!=null){
						for (var i = 0; i < json.length; i++) {
							tr = $('<tr/>');
							tr.append('<td>'
									+ json[i].question
									+ '</td>');
							tr.append('<td>'
									+ json[i].create_time.substring(0,json[i].create_time.lastIndexOf("-")+3)
									+ '</td>');
							tr.append('<td>'
									+ json[i].proposed_by
									+ " "
									+ '</td>');
							tr.append('<td> <b>Say more about your question to help other classrooms understand:</b><br>'
											+ json[i].description + "  "
											+"<br><b>What do you and your peers know about this issue now?</b><br>"
											+ json[i].issues + "  "
											+ '<br></td>');
							tr
							.append('<td>'+json[i].status+'</td>');
							
							if(json[i].status.toLowerCase()=="accepted"){
								tr.append('<td></td>')
								tr.append('<td><button onclick="superTalkStatus(\''
										+json[i].id+'\',0)" id="st_decline'+json[i].id
										+'" class="btn " style=" margin-left: 20px;">Decline</button><button  onclick="supertalk_SentMessage(\''+json[i].id+'\',1)" class="btn " style=" margin-left: 20px;">Message</button></td>');
						
								
							}
							if(json[i].status.toLowerCase()=="decline"){
								tr.append('<td><button onclick="superTalkStatus(\''+json[i].id+'\',1)" class="btn " style="text-align: center;">Accept</button>'
										+'<button  onclick="supertalk_SentMessage(\''+json[i].id+'\',1)" class="btn " style=" margin-left: 20px;">Message</button></td>');
								tr.append('<td></td>')
												}
							if(json[i].status.toLowerCase()=="pending"){
								tr.append('<td><button onclick="superTalkStatus(\''+json[i].id+'\',1)" class="btn " style="text-align: center;">Accept</button><button onclick="superTalkStatus(\''
										+json[i].id+'\',0)" id="st_decline'+json[i].id
										+'" class="btn " style=" margin-left: 20px;">Decline</button><button  onclick="supertalk_SentMessage(\''+json[i].id+'\',1)" class="btn " style=" margin-left: 20px;">Message</button></td>');
						
								
							}
							
							$('#super-talk-box').append(tr);
						}
					}
				
				},
				error : function(jqXHR, textStatus,
						errorThrown) {
					console.log(jqXHR.responseText);
				}
			});
			
			}
		
		
		$(".side-nav").find(".blue-grey").removeClass('blue-grey')
		$(".side-nav").find(".active").removeClass('active')
		$(".side-nav").find(".show").removeClass('show')

		$(".in-teacher-space").addClass("active blue-grey lighten-2 ")
		$(".in-teacher-space-body").addClass("show")
		$(".in-teacher").addClass("active")
	</script>
</body>
</html>