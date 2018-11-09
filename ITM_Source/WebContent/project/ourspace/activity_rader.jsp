<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<!--Import Google Icon Font-->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<!--Import materialize.css-->
<link type="text/css" rel="stylesheet"
	href="../../css/materialize.css" media="screen,projection" />
<link type="text/css" rel="stylesheet" href="../../css/customerize.css"
	media="screen,projection" />
	<link type="text/css" rel="stylesheet" href="../../css/jquery-ui.css"
	media="screen,projection" />
	<link type="text/css" rel="stylesheet" href="../../css/font-awesome-4.7.0/css/font-awesome.css"
	media="screen,projection" />
<!--Let browser know website is optimized for mobile-->
<script src="../../js/jquery-3.1.0.js"></script>
<script src="../../js/jquery-ui.js"></script>
<script src="../../js/jquery.sessionTimeout.js"></script>
<script src="../../js/itm.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta charset="UTF-8">


</head>

<body>

	<header>
		<%@ include file="../../header.jsp" %>
		<%@ include file="../../side_menu_hidden.jsp" %>
	</header>

	<main>
	<div class="container">
<br>
	
<div class="row">
<nav style="line-height:20px; height:20px;font-size: 15px;">
			<div class="nav-wrapper blue-grey" style="line-height:20px; height:20px">
				<div class="col s12">
						<a href="#!" onclick="enterProject()"  style="color:#dddddd">Dashboard&nbsp;&nbsp;&nbsp;</a> 
						<a href="#!" class="white-text" >Activity Radar&nbsp;&nbsp;&nbsp;</a>
					</div>
			</nav>
	<div class="col s12">
			 <ul id="tabs-swipe-demo" class="tabs">
    <li class="tab col s4"><a class="active" href="#test-swipe-1">Wondering Area</a></li>
    <li class="tab col s4"><a  href="#test-swipe-2">Thread Mapping</a></li>
     <li class="tab col s4" style="width: 32%;"><a  href="#test-swipe-3">Users</a></li>
  </ul>
  </div>
</div>
  <div id="test-swipe-1" class="col s12 ">
				<h6>
					Time period (recent <a id="w_1hr" href="javascript:initWRadar('h')">1 hour</a> / <a id="w_1day"
						href="javascript:initWRadar('d')">1 day</a> / <a id="w_1week" href="javascript:initWRadar('w')">1 week</a> / <a
						id="w_alltime" href="javascript:initWRadar('null')">all time</a> / set a date)
				</h6>
						<div
					style="padding-left: 20px; border: solid 5px; border-color: #78909c;">
					<table>
							<tr id="wondering_area_box">
								<th>Wondering area</th>
								<th>threads</th>
								<th>new posts</th>
								<th>my posts</th>
								<th>build-ons to my posts</th>
								<th>new highlights</th>
								<th>updated Journey of Thinking</th>
							</tr>
						
					</table>
				</div>
				
</div>
  <div id="test-swipe-2" class="col s12 ">
	<h6>
					Time period (recent <a id="t_1hr" href="javascript:initRadar('h')">1 hour</a> / <a id="t_1day"
						href="javascript:initRadar('d')">1 day</a> / <a id="t_1week" href="javascript:initRadar('w')">1 week</a> / <a
						id="t_alltime" href="javascript:initRadar('null')">all time</a> / set a date)
				</h6>
				<div
					style="padding-left: 20px; border: solid 5px; border-color: #78909c;">
					<table>
						<thead id="threadbox">
							<tr>
								<th>Threads</th>
								<th>new posts</th>
								<th>my posts</th>
								<th>build-ons to my posts</th>
								<th>new highlights</th>
								<th>updated Journey of Thinking</th>
							</tr>
							
						</thead>
					</table>
				</div>

</div>
  
    <div id="test-swipe-3" class="col s12 ">
	<h6>
					Time period (recent <a id="u_1hr" href="#">1 hour</a> / <a id="u_1day"
						href="#">1 day</a> / <a id="u_1week" href="#">1 week</a> / <a
						id="u_alltime" href="#">all time</a> / set a date)
				</h6>
				<div
					style="padding-left: 20px; border: solid 5px; border-color: #78909c;">
					<table>
						<thead id="userbox">
							<tr>
								<th>Threads</th>
								<th>new posts</th>
								<th>my posts</th>
								<th>build-ons to my posts</th>
								<th>new highlights</th>
								<th>updated Journey of Thinking</th>
							</tr>
							
						</thead>
					</table>
				</div>

</div>
			
			
			</div>
		</div>
	</div>
	</main>





	<!--Import jQuery before materialize.js-->
	
	<script type="text/javascript" src="../../js/materialize.min.js"></script>
	<script src="https://d3js.org/d3.v4.min.js"></script>
	<script src="../../js/notify.js"></script>
	<script type="text/javascript">

	$(".button-collapse").sideNav();
	$(".in-community").hide();
	$("#show_slide").click(function() {
		$('.button-collapse').sideNav('show');
	});
	
	
	 // global variables
	 
	 var localdb = getUrlParameter("crossdb");
	 var community_id=getUrlParameter("community_id");
	 var project_id=parseInt(getUrlParameter("projectid"));
	 var community_name=getUrlParameter("community_name");
	 var token="<%=session.getAttribute("super_token")%>"
	 var id='<%=session.getAttribute("id")%>';
	 var path =location.href
	 var isCrossProject = community_id!="<%=session.getAttribute("community_id")%>" ? true : false;
	 

		
	 function enterProject(){
		 
     	window.location.href = "dashboard.jsp?project_id="+project_id+"&localdb="+localdb+"&community_id="+community_id+"&community_name="+community_name;
		
	 }
	 
	 //http://localhost:8080/ITM3/project/ourspace/
	 //activity_rader.jsp?projectid=5&crossdb=localdb&community_id=57c052ea2057905c29008319&community_name=Guilderland%20Elementary%20School
	 function validateURL(){
		 if(null==getUrlParameter("crossdb")|| null == getUrlParameter("community_id") ||null==getUrlParameter("projectid")){
			 setTimeout(function(){ 
					Materialize.toast('Invalid URL', 4000)
					 //window.history.back();
				}, 3000);
		 }
	 }
	 
	 
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
					}else{
						
						console.log("do not find this community")
					}
					 get_project_info()
				},
				error : function(jqXHR, textStatus, errorThrown) {
					setTimeout(function(){ 
						Materialize.toast('Invalid URL', 4000)
						 //window.history.back();
					}, 3000);
				}
			});
		}else{
			setTimeout(function(){ 
				Materialize.toast('Invalid URL', 4000)
				 //window.history.back();
			}, 3000);
		}
		
	}
	
	// get project info
	
	function get_project_info(){
		
		if(null!=getUrlParameter("projectid")){
			var userdata = {
					"database" :localdb,
					"token" : token,
					"projectid" : parseInt(getUrlParameter("projectid"))
				};
			$.ajax({
				url : "/WSG/project/get/byid",
				type : "POST",
				data : JSON.stringify(userdata),
				dataType : "json",
				success : function(data, textStatus, jqXHR) {
					var json = $.parseJSON(data.obj);
					if(null!=json){
						if(isCrossProject){
							$("#page_title").html('<a href="../../dashboard.jsp">[CROSS COMMUNITY]'+community_name+'</a>-><a href="../openedit.jsp?community_id='+community_id+'&localdb='+localdb+'">'+json[0].title+'  Dashboard</a>')
						}else{
							$("#page_title").html('<a href="../../dashboard.jsp">'+community_name+'</a>-><a href="../openedit.jsp?community_id='+community_id+'&localdb='+localdb+'">'+json[0].title+'  Dashboard</a>')
						}
					}else{
								console.log("do not find this project")
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					setTimeout(function(){ 
						Materialize.toast('Invalid URL', 4000)
						 //window.history.back();
					}, 3000);
				}
			});
		}else{
			setTimeout(function(){ 
				Materialize.toast('Invalid URL', 4000)
				// window.history.back();
			}, 3000);
		}
		
	}
	
	var project=""
	
		 			$('select').material_select();
							function init(){
								intiActivityRadar()
								get_community_info()
							}
							init()
							
							
						
							
							var area=[];
							var thread=[];
							var notes=[];
							var members=[];
							var area_time=null;
							
							
							function intiActivityRadar(){
								
								var userdata = {
									"database" : localdb ,
									"token" : token,
									"pid" : project_id
								};
							$.ajax({
								url :  "/WSG/wondering_area/get/byprojectid",
								type : "POST",
								data : JSON.stringify(userdata),
								dataType : "json",
								success : function(data, textStatus, jqXHR) {
									var json = $.parseJSON(data.obj);
									console.log(json);
									if(null!=json){
										for (var i in json) {
											area[json[i].id]=json[i]
										}
										getThread()
									}
								},
								error : function(jqXHR, textStatus, errorThrown) {
									console.log(jqXHR.responseText);
								}
							});
							}
							
							
							
							function getThread(){
								// get thread
								var projectdata = {
										"database" :localdb ,
										"token" : token,
										"projectid" : project_id
									};
									$.ajax({
												url :  "/WSG/project/thread/get",
												type : "POST",
												data : JSON.stringify(projectdata),
												dataType : "json",
												success : function(data, textStatus,jqXHR) {
													var json = $.parseJSON(data.obj);
													console.log(json);
													if(null!=json){
														for (var i in json) {
															thread[json[i].id]=json[i]
														}
														// get thread note
														get_thread_note();
														
													}
												},
												error : function(jqXHR, textStatus,
														errorThrown) {
													//console.log(jqXHR.responseText);
												}
											});
							}
								
					
							
						// get thread note info
						function get_thread_note(){
							var tmpthreaddata = {
									"database" :localdb ,
									"token" : token,
									"pid" : project_id
								};
								$.ajax({
											url :  "/WSG/thread/note/get/byproject",
											type : "POST",
											data : JSON
													.stringify(tmpthreaddata),
											dataType : "json",
											success : function(data, textStatus,jqXHR) {
												var noteJson = $.parseJSON(data.obj);
												if(null!=noteJson){
													for (var i in noteJson) {
														if(typeof(notes[noteJson[i].note_id])!="undefined"){
															notes[noteJson[i].note_id].thread_id=String(notes[noteJson[i].note_id].thread_id)+"&"+String(noteJson[i].thread_id)	
														}else{
															notes[noteJson[i].note_id]=noteJson[i]	
														}
													}
													
												}
												// get user's note 
												get_user_note()
											}
								})
						}
							
							
						// get user's note 
						function get_user_note(){
							///note/get/byauthor
							var tmptUserdata = {
								"database" :localdb ,
								"token" : token,
								"authorid":'<%=session.getAttribute("id")%>'
							};
						
						$.ajax({
								url :  "/WSG/note/get/byauthor",
								type : "POST",
								data : JSON.stringify(tmptUserdata),
								dataType : "json",
								success : function(data, textStatus,jqXHR) {
									var userNoteJson = $.parseJSON(data.obj);
									if(null!=userNoteJson){
										for (var i in userNoteJson) {
											notes[userNoteJson[i].note_id] = $.extend(notes[userNoteJson[i].note_id],{"isMyNote":true})
									}
								 }
									// get my build on 
									get_buildon()
								}
							})
						}
						
						
						// get my build on 
						function get_buildon(){
							var tmptUserdata = {
									"database" :localdb ,
									"token" : token,
									"authorid":'<%=session.getAttribute("id")%>'
								};
							$.ajax({
								url :  "/WSG/buildon/get/byauthorid",
								type : "POST",
								data : JSON.stringify(tmptUserdata),
								dataType : "json",
								success : function(data, textStatus,jqXHR) {
									var userBuildonJson = $.parseJSON(data.obj);
									if(null!=userBuildonJson){
										for (var i in userBuildonJson) {
											if("undefined"!=typeof(notes[userBuildonJson[i].to_note_id])){
												if("undefined"==typeof(notes[userBuildonJson[i].to_note_id].buildon)){
													notes[userBuildonJson[i].to_note_id] = $.extend(notes[userBuildonJson[i].to_note_id],{"buildon":[noteJson[i]]})
					                			}else{
					                				notes[userBuildonJson[i].to_note_id].buildon.push(noteJson[i])
					                			}
											}
										}
									}
									// get highlight 
									get_thread_note_highlight()
									//getJOTByProjectId()
								}
							})
						}
						
						function get_thread_note_highlight(){
							var tmptUserdata = {
									"database" :localdb ,
									"token" : token
								};
							$.ajax({
								url :  "/WSG/highlight/get/all",
								type : "POST",
								data : JSON.stringify(tmptUserdata),
								dataType : "json",
								success : function(data, textStatus,jqXHR) {
									var highlightJson = $.parseJSON(data.obj);
									if(null!=highlightJson){
									for (var i in highlightJson) {
										if("undefined"!=typeof(notes[highlightJson[i].note_id])){
												if("undefined"==typeof(notes[highlightJson[i].note_id].highlight)){
													notes[highlightJson[i].note_id] = $.extend(notes[highlightJson[i].note_id],{"highlight":[highlightJson[i]]})
			                					}else{
			                						notes[highlightJson[i].note_id].highlight.push(highlightJson[i])
			                					}
											}
										}
									}
									
									// get thread JOT
									getJOTByProjectId()
							}
						})
						}
						
						function getJOTByProjectId(){
							// /project/jot/get/byprojectid
								var tmptUserdata = {
									"database" :localdb ,
									"token" : token,
									"pid":'project_id'
								};
							$.ajax({
								url :  "/WSG/project/jot/get/byprojectid",
								type : "POST",
								data : JSON.stringify(tmptUserdata),
								dataType : "json",
								success : function(data, textStatus,jqXHR) {
									var jotJson = $.parseJSON(data.obj);
									if(null!=jotJson){
									for (var i in jotJson) {
											if("undefined"!=typeof(thread[jotJson[i].thread_id])){
												if("undefined"==typeof(thread[jotJson[i].thread_id].jot)){
													thread[jotJson[i].thread_id] = $.extend(thread[jotJson[i].thread_id],{"jot":[jotJson[i]]})
				                				}else{
				                					thread[jotJson[i].thread_id].jot.push(jotJson[i])
				                				}
											}
										}
									}
									combineNoteThread()
							}
						})
							
						}
						
						function get_wondering_area_thread(){
							var linkdata = {
									"database" :localdb ,
									"token" : token,
									"pid":project_id
							};
							$.ajax({
										url :  "/WSG/wondering_area/thread/get/byprojectid",
										type : "POST",
										data : JSON.stringify(linkdata),
										dataType : "json",
										success : function(data, textStatus, jqXHR) {
											var json = $.parseJSON(data.obj);
											console.log(json);
											if(null!=json){
											for (var i = 0; i < json.length; i++) {
													console.log(json[i])
													if(null!=thread[json[i].thread_id]){
													if(typeof(area[json[i].wondering_area_id])!="undefined"){
														if(typeof(area[json[i].wondering_area_id].thread)!="undefined"){
																area[json[i].wondering_area_id].thread.push(thread[json[i].thread_id])
														}else{
															area[json[i].wondering_area_id] = $.extend(area[json[i].wondering_area_id],{"thread":[thread[json[i].thread_id]]})
														}
													}else{
														console.log("An error with wondering area and thread. The project has a thread link to unknown wondering area")
														
													}
													}else{
														console.log("can not find thread info")
													}
													
												}
											}
											
											initRadar(null)	
											initWRadar(null)
										},
										error : function(jqXHR, textStatus,
												errorThrown) {
											console.log(jqXHR.responseText);
										}
									});
							
						}
						
						
						function combineNoteThread(){
							for (var i in notes) {
							
								var threads = String(notes[i].thread_id).split("&");
								for(var j in threads){
									if("undefined"!=typeof(thread[threads[j]])){
										if(notes[i].thread_id!=""){
										if("undefined"==typeof(thread[threads[j]].notes)){
											thread[threads[j]] = $.extend(thread[threads[j]],{"notes":[notes[i]]})
		                				}else{
		                					thread[threads[j]].notes.push(notes[i])
		                				}
										}
									}
									
								}
							}
							
							get_wondering_area_thread()
							
						}
						
						var thread_time=null;
						function initRadar(time){
							$("#threadbox").empty().html("");
							$("#threadbox").html(
							"<tr>"
							+"<th>Threads</th>"
							+"<th>new posts</th>"
							+"<th>my posts</th>"
							+"<th>build-ons to my posts</th>"
							+"<th>new highlights</th>"
							+"<th>updated Journey of Thinking</th>"
							+"</tr>")
							thread_time=time
							var bound_time =new Date("1966-06-07T14:51:16.195Z");
							var d= new Date();
							if(null!=time){
								switch(time) {
							    case "h":
							    	bound_time = d.setHours(d.getHours() - 1);
							        break;
							    case "d":
							    	bound_time = d.setDate(d.getDate() - 1);
							        break;
							    case "w":
							    	bound_time = d.setDate(d.getDate() - 7);
							        break;
								}
							}
							
							if(null!=thread&&""!=thread){
								for (var i in thread) {
									var num_thread=0;
									var num_new_post=0;
									var num_my_post=0;
									var num_build_on=0;
									var num_highlights=0;
									var num_jot=0;
									
									var tr =$("#threadbox")
									if("undefined"!=typeof(thread[i].jot)){
										for(var k in thread[i].jot){
											if(new Date(thread[i].jot[k].time_stamp).getTime()>new Date(bound_time).getTime()){
												num_jot=num_jot+1
											}
										}
									}
								
													if(null!=thread[i].notes){
														for(var  j in thread[i].notes){
															if("undefined"!=typeof(thread[i].notes[j].highlight)){
																for(var m in thread[i].notes[j].highlight){
																	if(new Date(thread[i].notes[j].highlight[m].create_time).getTime()>new Date(bound_time).getTime()){
																		num_highlights=num_highlights+1
																	}
																}
															}
															
															if(new Date(thread[i].notes[j].create_time).getTime()>new Date(bound_time).getTime()){
																num_new_post=num_new_post+1
																if("undefined"!=typeof(thread[i].notes[j].isMyNote)){
																	if(thread[i].notes[j].isHighlight){
																		if(bound_time!=""){
																			num_highlights=num_highlights+1
																		}
																		
																	}
																}
																if("undefined"!=typeof(thread[i].notes[j].isMyNote)){
																	if(thread[i].notes[j].isMyNote){
																		num_my_post=num_my_post+1
																		}
																	}
															}
														}
													}
								
										tr.append('<tr ><td ><a class="threadsclick" target="_blank" href="#" id="'+ thread[i].id +'">&nbsp;&nbsp;'
										+ thread[i].threadfocus  
										+ '</a></td>'
										+'<td>&nbsp;'+num_new_post+'</td>'
										+'<td>&nbsp;'+num_my_post+'</td>'
									 	+'<td>&nbsp;'+num_build_on+'</td>'
										+'<td>&nbsp;'+num_highlights+'</td>'
										+'<td>&nbsp;'+num_jot+'</td>'
										+'</tr>')
										
									
								}
							}
							
						}
						
						
						
						function initWRadar(time){
							area_time=time
							$("#wondering_area_box").empty().html()
							$("#wondering_area_box").html("<tr>"
								+"<th>Wondering area</th>"
								+"<th>Threads</th>"
								+"<th>new posts</th>"
								+"<th>my posts</th>"
								+"<th>build-ons to my posts</th>"
								+"<th>new highlights</th>"
								+"<th>updated Journey of Thinking</th>"
								+"</tr>");
							
							var bound_time =new Date("1966-06-07T14:51:16.195Z");
							var d= new Date();
							if(null!=time){
								switch(time) {
							    case "h":
							    	bound_time = d.setHours(d.getHours() - 1);
							        break;
							    case "d":
							    	bound_time = d.setDate(d.getDate() - 1);
							        break;
							    case "w":
							    	bound_time = d.setDate(d.getDate() - 7);
							        break;
								}
							}
							
							if(null!=area&&""!=area){
								for (var i in area) {
													var num_thread=0;
													var num_new_post=0;
													var num_my_post=0;
													var num_build_on=0;
													var num_highlights=0;
													var num_jot=0;
													if(null!=area[i].thread&&""!=area[i].thread){
														for(var j in area[i].thread){
															var thread =  area[i].thread[j]
															num_thread=num_thread+1
															if("undefined"!=typeof(thread.jot)){
																for(var k in thread.jot){
																	if(new Date(thread.jot[k].time_stamp).getTime()>new Date(bound_time).getTime()){
																		num_jot=num_jot+1
																	}
																}
															}
															if(null!=thread.notes){
																for(var k in thread.notes){
																	if("undefined"!=typeof(thread.notes[k].highlight)){
																		for(var m in thread.notes[k].highlight){
																			if(new Date(thread.notes[k].highlight[m].create_time).getTime()>new Date(bound_time).getTime()){
																				num_highlights=num_highlights+1
																			}
																		}
																	}
																		if(new Date(thread.notes[k].create_time).getTime()>new Date(bound_time).getTime()){
																			num_new_post=num_new_post+1
																			
																			if("undefined"!=typeof(thread.notes[k].isMyNote)){
																				if(thread.notes[k].isMyNote){
																					num_my_post=num_my_post+1
																					}
																				}
																		}
																	
																	
																}
															}
														}
													}
													
													var tr =$("#wondering_area_box")
													tr.append('<tr><td> <a  href="#" ><i class="fa fa-plus " data-id="'+ area[i].id +'"aria-hidden="true"></i></a>&nbsp;&nbsp;'
																	+ area[i].name  
																	+ '</td>'
																	+'<td>'+num_thread+'</td>'
													+'<td>'+num_new_post+'</td>'
													+'<td>'+num_my_post+'</td>'
												 	+'<td>'+num_build_on+'</td>'
													+'<td>'+num_highlights+'</td>'
													+'<td>'+num_jot+'</td>'
													+'</tr>')
								}
							}
							
						}
						
						$(document)
						.delegate('.fa-minus','click',function() {
							$(this).removeClass( "fa-minus" ).addClass( "fa-plus" );
							if(null!=area[$(this).data("id")].thread){
								for(var i in area[$(this).data("id")].thread){
									var thread =area[$(this).data("id")].thread[i]
									$( ".addon"+$(this).data("id") ).remove();
									}
								}
							
							
						})
						$(document)
								.delegate('.fa-plus','click',function() {
									var bound_time =new Date("1966-06-07T14:51:16.195Z");
									var d= new Date();
									if(null!=area_time){
										switch(area_time) {
									    case "h":
									    	bound_time = d.setHours(d.getHours() - 1);
									        break;
									    case "d":
									    	bound_time = d.setDate(d.getDate() - 1);
									        break;
									    case "w":
									    	bound_time = d.setDate(d.getDate() - 7);
									        break;
										}
									}
									
										var tr =$(this.parentElement.parentElement.parentElement)
										$(this).removeClass( "fa-plus" ).addClass( "fa-minus" );
										
										if(null!=area[$(this).data("id")].thread){
											for(var i in area[$(this).data("id")].thread){
												var num_thread=0;
												var num_new_post=0;
												var num_my_post=0;
												var num_build_on=0;
												var num_highlights=0;
												var num_jot=0;
												
												
												
												var thread =area[$(this).data("id")].thread[i]
												if("undefined"!=typeof(thread.jot)){
													for(var k in thread.jot){
														if(new Date(thread.jot[k].time_stamp).getTime()>new Date(bound_time).getTime()){
															num_jot=num_jot+1
														}
													}
												}
											
																if(null!=thread.notes){
																	for(var  j in thread.notes){
																		if("undefined"!=typeof(thread.notes[j].highlight)){
																			for(var m in thread.notes[j].highlight){
																				if(new Date(thread.notes[j].highlight[m].create_time).getTime()>new Date(bound_time).getTime()){
																					num_highlights=num_highlights+1
																				}
																			}
																		}
																		
																		if(new Date(thread.notes[j].create_time).getTime()>new Date(bound_time).getTime()){
																			num_new_post=num_new_post+1
																			if("undefined"!=typeof(thread.notes[j].isMyNote)){
																				if(thread.notes[j].isHighlight){
																					if(bound_time!=""){
																						num_highlights=num_highlights+1
																					}
																					
																				}
																			}
																			if("undefined"!=typeof(thread.notes[j].isMyNote)){
																				if(thread.notes[j].isMyNote){
																					num_my_post=num_my_post+1
																					}
																				}
																		}
																	}
																}
											
													tr.after('<tr class="addon'+$(this).data("id")+'"><td colspan=2><a class="threadsclick"    href="#" id="'+ thread.id +'">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'
													+ thread.threadfocus 
													+ '</a></td>'
													+'<td>&nbsp;'+num_new_post+'</td>'
													+'<td>&nbsp;'+num_my_post+'</td>'
												 	+'<td>&nbsp;'+num_build_on+'</td>'
													+'<td>&nbsp;'+num_highlights+'</td>'
													+'<td>&nbsp;'+num_jot+'</td>'
													+'</tr>')
																
											}
										}
										
														
										});
						
							$(document)
									.delegate('.threadsclick','click',function() {
										
										 window.open("../../thread/thread.jsp?localdb="+localdb+"&community_id="+community_id+"&project_id="+project_id+"&thread_id="+$(this)[0].id);
											});
							

	
		
		$(".side-nav").find(".blue-grey").removeClass('blue-grey')
		$(".side-nav").find(".active").removeClass('active')
		$(".side-nav").find(".show").removeClass('show')

		$(".in-work-space").addClass("active blue-grey lighten-2 ")
		$(".in-work-space-body").addClass("show")
		$(".in-work").addClass("active")
		sessionTimeOut(<%=session.getAttribute("SessionTimeOut")%>)
	</script>
</body>
</html>