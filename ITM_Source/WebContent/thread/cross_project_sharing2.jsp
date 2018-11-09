<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!DOCTYPE html>
<html>
<head>
<!--Import Google Icon Font-->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<link href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"
	rel="stylesheet">
<!--Import materialize.css-->
<link type="text/css" rel="stylesheet" href="../css/materialize.min.css"
	media="screen,projection" />
	<link type="text/css" rel="stylesheet"
	href="../css/customerize.css" media="screen,projection" />
<script src="../js/d3.v3.min.js"></script>
<script src="../js/d3.tip.v0.6.3.js"></script>

<!--Let browser know website is optimized for mobile-->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta charset="UTF-8">
<script src="../js/plotly-latest.min.js"></script>
<script src="../js/jquery-3.1.0.js"></script>
<script src="../js/jquery-ui.js"></script>
<script src="../js/jquery.sessionTimeout.js"></script>
<script type="text/javascript" src="../js/materialize.min.js"></script>
<style>
td{
    vertical-align: top;
    
   }
#graph-container {
	
	margin: 0px;
}

.brand-logo {
	height: 100px;
}

#resizable {
	width: 150px;
	height: 150px;
	padding: 0.5em;
}

.tabs .indicator {
	color: black;
	background-color: black;
}

.modal {
	width: 95% !important
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
	width: 100%;
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

.collapsible-body {
	padding: 0px !important;
}
</style>


</head>

<body>

	<header>
		<%@ include file="../header.jsp" %>
		<%@ include file="../side_menu_hidden.jsp" %>
	</header>




	<main id="pdf_test"> <br>
	<div class="container" id="content">
		<div class="row">
			<div class="col s12">
				<ul class="tabs tabs-fixed-width">
					<li class="tab col s3 blue-grey lighten-5"><a href="#test1"
						class="blue-grey-text">Buddy projects</a></li>
					<li class="tab col s3 blue-grey lighten-5"><a href="#test2"
						class="blue-grey-text">Resource projects</a></li>
				</ul>
			</div>
			<div id="test1" class="col s12">
				<div class="col s9" style="border-right: 1px solid;">
					<h6>
						<p>
							<u>Buddy projects from the current database/community</u> <a
								id="jof" style="line-height: 20px; height: 20px"
								class="btn right">journey of thinking</a>
						</p>
					</h6>
					
					<div class="col s12" id="buddyproject">
					<div class="col s12" id="buddyprojectcontent">
						
					</div>
					</div>
					<div class="col s6" id="graph-container"></div>
					
				</div>
				<div class="col s3">
					<p style="font-size: 20px">
						<u>"Super talk" across-classroom</u>
					</p>
					<!-- <div id="editor"></div>
				<button id="cmd">generate PDF</button> -->
					<a href="#" id="post_challenge" class="btn">Post a "Super talk"
						topic</a>

					<div class="divider"></div>
					<br>
					<p style="font-size: 15px">List of existing "super talk"
						topics:</p>
					<table class="bordered highlight">
						<thead id="wabox">
							<tr>
								<th>Topic name</th>
								<th>Proposed by</th>
								<th>Number of Notes</th>
							</tr>
							</thead>
							<tbody id="super-talk-list">
							
							</tbody>
							
					</table>
				</div>

			</div>
			<div id="test2" class="col s12" style="height: 740px;"></div>



		</div>
	</div>


	</main>

	<div id="add_field_modal" class="modal modal-fixed-footer">
		<div class="modal-content">
			<div class="container">
				<div class="row">
					<canvas class="col s7" id="canvas" width="650" height="1000"></canvas>
					<div class="col s5">
						<ul class="collection with-header" id="jot">

						</ul>
					</div>
				</div>
			</div>

		</div>
	</div>

	<div id="thread_modal" class="modal modal-fixed-footer">
		<div class="modal-content">
			<div class="container">
				<div class="row"></div>
			</div>

		</div>
	</div>

	<div id="post_challenge_modal" class="modal modal-fixed-footer">
		<div class="modal-content">
			<div class="container">
				<div class="row">
					<p style="font-size: 20px; text-align: center">Post a "big
						question" to invite ideas from other classrooms</p>
					<div class="input-field col s12">
						<input id="question" type="text" class="validate"> <label
							for="question">Challenge question</label>
					</div>
					<div class="input-field col s12">
						<input value="Alvin" id="proposed_by" type="text" class="validate">
						<label class="active" for="proposed_by">Proposed by</label>
					</div>
					<div class="input-field col s12">
						<input id="detail" type="text" class="validate"> <label
							for="detail">Say more about your question to help other
							classrooms understand:</label>
					</div>
					<div class="input-field col s12">
						<input id="know_now" type="text" class="validate"> <label
							for="know_now">What do you and your peers know about this
							issue now?</label>
					</div>
					<form action="#" class="col s12">
						<p style="font-size: 20px; text-align: center">Related idea
							thread(s) from your classroom:</p>
						<div id="thread-list">
							
						</div>
					</form>
				</div>
			</div>

		</div>
		<div class="modal-footer">
			<a href="#!" id="btn_super_talk_add"
				class="modal-action modal-close waves-effect waves-green btn-flat ">Submit</a>
			<a href="#!"
				class="modal-action modal-close waves-effect waves-green btn-flat ">Cancel</a>
		</div>
	</div>


	<div id="jofmodal" class="modal modal-fixed-footer">
		<div id="pdf_print" class="modal-content">
			<h4 class="center">Journey of Thinking</h4>
			<div class="container" style="margin-left: 0; margin-right: 0;width:100%;max-width: 2880px; ">
			<div id="jot_content" class="row" style="border: 1px solid;word-wrap: break-word;  margin-left: 0; margin-right: 0;">
						
			
			</div>
						
				</div>
		</div>
		<div id="editor"></div>
		<div class="modal-footer">
			<a href="#!" id="cmd"
				class="modal-action modal-close waves-effect waves-green btn-flat ">Download</a>
			<a href="#!"
				class="modal-action modal-close waves-effect waves-green btn-flat ">Close</a>
		</div>
	</div>


	<!--Import jQuery before materialize.js-->
	<script type="text/javascript" src="../js/materialize.min.js"></script>
	<script src="https://d3js.org/d3.v4.min.js"></script>
	<script>
	
	
	var project_id = <%=session.getAttribute("projectid")%>;
	var json =JSON.parse(localStorage.projects);
	project = json[project_id]
	
	
	$("#page_title").html('<a href="../dashboard.jsp"><%=session.getAttribute("community")%></a>><a href="../project/openedit.jsp">'+project.title+'</a> \'s cross-project sharing space')

	
	$(document).ready(function() {
							
							var wondering_area_id=[];
							var wondering_area_name=[];
							var localdb="<%=session.getAttribute("localdb")%>";
							var token="<%=session.getAttribute("token")%>";
							var community="<%=session.getAttribute("community")%>";
							var c_id="<%=session.getAttribute("community_id")%>";
							var type="<%=session.getAttribute("role")%>";
							var urname="<%=session.getAttribute("username")%>";
							var id="<%=session.getAttribute("id")%>";
							var itmdb="<%=session.getAttribute("ITMDatabase")%>";
							var domain="<%=session.getAttribute("domain")%>";
							var token="<%=session.getAttribute("token")%>";
							var school="<%=session.getAttribute("school")%>";
							var country="<%=session.getAttribute("country")%>";
							var city="<%=session.getAttribute("city")%>";
							var project_id="<%=session.getAttribute("projectid")%>";
							var buddy_project_id=""
							var project="";
							var all_project_id = [];
							var data_for_visualization=[];
							var viz_id=[];
							$(".modal").modal();
								$("#jof").click(function() {
									$("#jofmodal").modal("open");
								})
							$(".button-collapse").sideNav();
							$("#show_slide").click(function() {
								$('.button-collapse').sideNav('show');
							});
							Materialize.updateTextFields();
							$("#post_challenge").click(function() {
								$("#post_challenge_modal").modal("open");
							});

							var jsondata = {
								"database" :"itm3" ,
								"token" : '<%=session.getAttribute("token")%>',
								"projectid" : parseInt($("#projectid").text()),
								"localdb" : "localdb"
							};
							
							$(".thread").click(function(){
								console.log($(this)[0].id);
								
								$
										.ajax({
											url : '../SET_THREAD_FOCUS',
											type : 'POST',
											data : {
												threadid : $(this)[0].id,
												threadname : $(
														this)
														.text()
											},
											success : function(
													response) {
												window.location.href = "../thread/thread.jsp";
											}
										});
								
							});
							
							
							
							$(".project").click(function(){
								console.log($(this)[0].id);
								
								$.ajax({
					                url: '../SET_PROJECT_FOCUS',
					                type: 'POST',
					                data: {projectid: $(this)[0].id, projectgoal: "Understand how the amazing human body works!", projectname:$(this).text()},
					                success: function (response) {
					                	window.location.href = "../project/ourspace/dashboard.jsp";
					                }
					            });
								
							});
							
							
							function init(){
								
								var json = {
										"database" :'itm3' ,
										"token" : '<%=session.getAttribute("token")%>',
										"pid":<%=session.getAttribute("projectid")%>,
										"cid":'<%=session.getAttribute("community_id")%>'
									};
								$.ajax({
									url :  "/WSG/my_buddy_project/get",
									type : "POST",
									data : JSON.stringify(json),
									dataType : "json",
									success : function(data, textStatus, jqXHR) {
												//console.log(data);
											if(data.code=="success"){
							  if($.trim(data.desc)!=$.trim("No data aviliable.")){
								  var json = $.parseJSON(data.obj);
								  var removeDulpicateProject;
								  var section={}
								  for(var i in json){
									  if(typeof(section[json[i].community_id])=="undefined"){
										  section[json[i].community_id]=1
										  $('#buddyprojectcontent').append("<div id='section_"+json[i].community_id+"'><h6><b>"+json[i].community+"</b></h6></div>");  
										  $('#jot_content').append("<div id='jot_"+json[i].community_id+"' style=\"word-wrap: break-word;\"></div>");  
										  
									  }
									   
									  	var tr = $('<div class="card horizontal" id="'+json[i].id+'"/>');
										var html = ' <div class="card-image"><img style="height:100px; width:75px;margin-top:33px" id="project_img_'+json[i].id+json[i].community_id+'"  src="'+json[i].logo+'"></div><div class="card-stacked"><div class="card-content" ><h6><strong><span id="project_title_'+json[i].id+json[i].community_id+'">'
										+ json[i].project_title
										+ '</span<</strong></h6><p><strong>Project goal:</strong> <span id="project_goal_'+json[i].id+json[i].community_id+'">'+ json[i].goal
										+ '</span><strong>&nbsp;Curriculum area: </strong> <span id="project_area_'+json[i].id+json[i].community_id+'">'+json[i].curriculum
										+ '</span><strong>&nbsp;Teacher(s): </strong><span id="project_teacher_'+json[i].id+json[i].community_id+'"> '+json[i].teachers
										+'</span><strong>&nbsp;Grade : </strong><span id="project_grade_level_'+json[i].id+json[i].community_id+'">'+json[i].grade_level
										html = html +'<span></p><br><a href="javascript:enterProject('+json[i].project_id+',\''+json[i].localdb+'\',\''+json[i].community_id+'\',\''+json[i].school+'\');" class="btn col s1">Enter</a> <a id="btn_'+json[i].project_id+i+'" style="margin-left:10px" onclick="toggleVisualization('+json[i].project_id+i+','+json[i].project_id+',\''+json[i].localdb+'\')" class="btn col s6">Show wondering areas and idea threads</a>';
										html = html +'</p>';
										html = html+'</div></div>'
										tr.append(html);
										$('#section_'+json[i].community_id).append(tr); 
										var tr1 = $('<div style="height:410px;display:none;border:1px solid grey" id="tree_'+json[i].project_id+i+'"></div>');
										viz_id.push("#tree_"+json[i].project_id+i);
										$('#section_'+json[i].community_id).append(tr1);  
										all_project_id.push(json[i].project_id);
							  			
										var uniqueIds = [];
										$.each(all_project_id, function(i, el){
										    if($.inArray(el, uniqueIds) === -1) uniqueIds.push(el);
										});
										
										
										if(parseInt(i)+1!=json.length){
											 var jot_content_html="<div id='jot_"+json[i].community_id+json[i].id+"' class=\"row\" style=\"border-bottom: 1px solid;margin-bottom: 0px; margin-left: 0; margin-right: 0; \">"
											    +"<table ><tr>"
											    +"<td style='width:30%'>"
												+"<img style=\"width:181px;\"  id='jot_img_"+json[i].community_id+json[i].id+"' src='#'/>"
												+"	<br>Project title：<a> <span  id='jot_title_"+json[i].community_id+json[i].id+"'></span></a>"
												+"	<br>Teacher(s)：<span id='jot_teacher_"+json[i].community_id+json[i].id+"'>  </span>"
												+"	<br>School:<span id='jot_school_"+json[i].community_id+json[i].id+"'>  </span><br>"
												+"</td>"
												+"<td style=\"border-left: 1px solid;min-height: 150px; solid;width:70%\"   id='jot_content_"+json[i].community_id+json[i].project_id+"'>"
												+"</td></tr>"
												 +"</table >"
												 $('#jot_'+json[i].community_id).append(jot_content_html)
										}else{
											 var jot_content_html="<div id='jot_"+json[i].community_id+json[i].id+"' class=\"row\" style=\"margin-bottom: 0px; margin-left: 0; margin-right: 0; \">"
											    +"<table ><tr>"
											    +"<td style='width:30%'>"
												+"<img style=\"width:181px;\"  id='jot_img_"+json[i].community_id+json[i].id+"' src='#'/>"
												+"	<br>Project title：<a> <span  id='jot_title_"+json[i].community_id+json[i].id+"'></span></a>"
												+"	<br>Teacher(s)：<span id='jot_teacher_"+json[i].community_id+json[i].id+"'>  </span>"
												+"	<br>School:<span id='jot_school_"+json[i].community_id+json[i].id+"'>  </span><br>"
												+"</td>"
												+"<td style=\"border-left: 1px solid;min-height: 150px; solid;width:70%\"   id='jot_content_"+json[i].community_id+json[i].project_id+"'>"
												+"</td></tr>"
												 +"</table >"
												 $('#jot_'+json[i].community_id).append(jot_content_html)
											
										}
 										// -------------------------------------------------------------------------
									    	
									   
										 
										initProject(json[i].localdb,json[i].project_id,json[i].id,json[i].community_id)
									    
										/* var tr1 = $('<div style="height:410px;display:none;border:1px solid grey" id="tree_'+json[i].project_id+i+'"></div>');
										viz_id.push("#tree_"+json[i].project_id+i);
										//$('#buddyprojectcontent').append(tr1);  
										$(json[i].id).after(tr1);  
										all_project_id.push(json[i].project_id);
										initProject(json[i].localdb,json[i].project_id,json[i].id,json[i].community_id)
										var uniqueIds = [];
										$.each(all_project_id, function(i, el){
										    if($.inArray(el, uniqueIds) === -1) uniqueIds.push(el);
										}); */
								  }
								  
								  initSuperTalkList(json)
							  		}
							  }		
											},
											error : function(jqXHR, textStatus,
													errorThrown) {
												console.log(jqXHR.responseText);
											}
										});
								
								
							}
							init()
							
							
							function initProject(localdb,projectId,id,cid){
								
								
								var json = {
										"database" :localdb ,
										"token" : '<%=session.getAttribute("token")%>',
										"pid":projectId,
										"projectid":projectId
									};
								$.ajax({
									url :  "/WSG/project/get/byid",
									type : "POST",
									data : JSON.stringify(json),
									dataType : "json",
									success : function(data, textStatus, jqXHR) {
										if(data.code=="success"){
											  if($.trim(data.desc)!=$.trim("No data aviliable.")){
												  var json = $.parseJSON(data.obj);
												  $('#project_img_'+id+cid).attr("src",json[0].logo);
												  $('#project_goal_'+id+cid).html(json[0].goal);
												  $('#project_title_'+id+cid).html(json[0].title);
												  
												  
												  $("#jot_img_"+cid+id).attr("src",json[0].logo);
												  $("#jot_title_"+cid+id).html(json[0].title);
												  $("#jot_school_"+cid+id).html(json[0].school);
											  }
										
										}
									}
								})
								
								$.ajax({
									url :  "/WSG/project/teacher/get/byid",
									type : "POST",
									data : JSON.stringify(json),
									dataType : "json",
									success : function(data, textStatus, jqXHR) {
										if(data.code=="success"){
											  if($.trim(data.desc)!=$.trim("No data aviliable.")){
												  var json = $.parseJSON(data.obj);
												  for(var i in json){
													  $('#project_teacher_'+id+cid).append(json[i].first_name+"    "+json[i].last_name+",");
													  $("#jot_teacher_"+cid+id).append(json[i].first_name+"    "+json[i].last_name+",");
												  }
												 
											  }
										}
										
										
									}
									
								})
								$.ajax({
									url :  "/WSG/project/grade/get/byid",
									type : "POST",
									data : JSON.stringify(json),
									dataType : "json",
									success : function(data, textStatus, jqXHR) {
										if(data.code=="success"){
											  if($.trim(data.desc)!=$.trim("No data aviliable.")){
												  for(var i in json){
													  $('#project_grade_level_'+id+cid).append(json[i].title+",  ");

												  }
											  
											  }
										}
										
									}
									
								})
								
								$.ajax({
									url :  "/WSG/project/curriculum/get/byid",
									type : "POST",
									data : JSON.stringify(json),
									dataType : "json",
									success : function(data, textStatus, jqXHR) {
										if(data.code=="success"){
											  if($.trim(data.desc)!=$.trim("No data aviliable.")){
												  var json = $.parseJSON(data.obj);
												  for(var i in json){
													  $('#project_area_'+id+cid).append(json[i].name+",  ");

												  }
											  }
										}
										
										
										
									}
									
								})
								
								
								$.ajax({
									url :  "/WSG/project/jot/get/byprojectid",
									type : "POST",
									data : JSON.stringify(json),
									dataType : "json",
									success : function(data, textStatus, jqXHR) {
										if(data.code=="success"){
											  if($.trim(data.desc)!=$.trim("No data aviliable.")){
												  var threadid={}
												  var json = $.parseJSON(data.obj);
												  for(var i in json){
													 // if(typeof(threadid[json[i].thread_id])=="undefined"){
														  threadid[json[i].thread_id]=1
														  var jot_html =""
														  if(parseInt(i)+1!=json.length){
															   jot_html =
																	"	<div id='jot_details_"+json[i].thread_id+projectId+"' style=\"border-bottom: 1px solid\">"
																	+"	Thread: <a><span id='jot_details_thread_"+json[i].thread_id+projectId+"'>"+json[i].threadfocus+"</span></a>"
																	+"	<br> "
																	+"	<b>Our problems:</b>"
																	+"	<span id='jot_details_problem_"+json[i].thread_id+projectId+"'></span>"
																	+"	<br><b>Big ideas we have learned::</b>"
																	+"	<span id='jot_details_idea_"+json[i].thread_id+projectId+"'></span>"
																	+"	<br>"
																	+"	<b>We need to do more:</b>"
																	+"	<span id='jot_details_more_"+json[i].thread_id+projectId+"'></span>"
																	+"	</div>"

															  
														  }else(
																  jot_html =
																		"	<div id='jot_details_"+json[i].thread_id+projectId+"' >"
																		+"	Thread: <a><span id='jot_details_thread_"+json[i].thread_id+projectId+"'>"+json[i].threadfocus+"</span></a>"
																		+"	<br> "
																		+"	<b>Our problems:</b>"
																		+"	<span id='jot_details_problem_"+json[i].thread_id+projectId+"'></span>"
																		+"	<br><b>Big ideas we have learned::</b>"
																		+"	<span id='jot_details_idea_"+json[i].thread_id+projectId+"'></span>"
																		+"	<br>"
																		+"	<b>We need to do more:</b>"
																		+"	<span id='jot_details_more_"+json[i].thread_id+projectId+"'></span>"
																		+"	</div>"
														  )
														  $("#jot_content_"+cid+projectId).append(jot_html);  
														  
													  //}
													  
													  
													
													  $("#jot_details_problem_"+json[i].thread_id+projectId).append(""+json[i].ourproblem+",");
													  $("#jot_details_idea_"+json[i].thread_id+projectId).append(""+json[i].bigidea+",");
													  $("#jot_details_more_"+json[i].thread_id+projectId).append(""+json[i].more+",");

											  
											  }
											 }else{
												 
												 var jot_html =
														"	<div id='jot_details_"+json[i].thread_id+projectId+"' style=\"border-bottom: 1px solid\">"
														+"No data"
														+"	</div>"

												  $("#jot_content_"+cid+projectId).append(jot_html);  
														
											 }
										}
										
									}
									
								})
								
								
							}
					
							initWondering_areaThread()
							function initWondering_areaThread(){
								var all_buddy_project_id = [];
								
								var json = {
										"database" :'itm3' ,
										"token" : token,
										"pid":<%=session.getAttribute("projectid")%>,
										"cid":'<%=session.getAttribute("community_id")%>'
									};
								
								$.ajax({
									url :  "/WSG/my_buddy_project/get",
									type : "POST",
									data : JSON.stringify(json),
									dataType : "json",
									success : function(data, textStatus, jqXHR) {
								  var json = $.parseJSON(data.obj);
								  for(var i=0;i<json.length; i++){
									all_buddy_project_id.push(json[i].project_id);
									//addNodes(json[i].project_id,i);
								  }
									},
							error : function(jqXHR, textStatus,
									errorThrown) {
								console.log(jqXHR.responseText);
							}
						});
							}
							
					
						});
							
							
							function enterProject(ProjectId,crossdb,cid,cname){
								$.ajax({
							        url: '../SET_CROSS_PROJECT_FOCUS',
							        type: 'POST',
							        data: {'projectid': ProjectId,'projectname': "",'crossdb':crossdb,'community_id':cid,'community_name':cname},
							        success: function (response) {
							        	window.location.href = "../project/cross/dashboard.jsp";
							        }
								});
							}
						
							var threadname = [];
							var wonderingarea = [];
							var projecttitle = [];
							
						function drawVisualization(data_for_visualization,id){
								var projectData = $.parseJSON(data_for_visualization);
								
								var dataMap = projectData.reduce(function(map, node) {
									map[node.name] = node;
									return map;
								}, {});
								var treeData = [];
								projectData.forEach(function(node) {
									var parent = dataMap[node.parent];
									if (parent) {
										(parent.children || (parent.children = []))
											.push(node);
									} else {
										treeData.push(node);
									}
								});
								var margin = {top: 20, right: 20, bottom: 20, left: 120},
									width = 800 - margin.right - margin.left,
									height = 400 - margin.top - margin.bottom;
									
								var i = 0;

								var tree = d3.layout.tree()
									.size([height, width]);

								var diagonal = d3.svg.diagonal()
									.projection(function(d) { return [d.y, d.x]; });
								
								

								
								var svg = d3.select("#"+id).append("svg")
									.attr("width", width + margin.right + margin.left)
									.attr("height", height + margin.top + margin.bottom)
								  	.append("g")
									.attr("transform", "translate(" + margin.left + "," + margin.top + ")");
								
								root = treeData[0];
								  
								update(root);

								function update(source) {

								  var nodes = tree.nodes(root).reverse(),
									  links = tree.links(nodes);

								  nodes.forEach(function(d) { d.y = d.depth * 300; });

								  var node = svg.selectAll("g.node")
									  .data(nodes, function(d) { return d.id || (d.id = ++i); });

								  var nodeEnter = node.enter().append("g")
									  .attr("class", "node")
									  .attr("transform", function(d) { 
										  return "translate(" + d.y + "," + d.x + ")"; })
										.on("click", click)
										.attr('cursor', 'pointer');

								  nodeEnter.append("circle")
									  .attr("r", 10)
									  .style("fill", "steelblue");

								  nodeEnter.append("text")
									  .attr("x", function(d) { 
										  return d.children || d._children ? -13 : 13; })
									  .attr("dy", "20px")
									  .attr("size","9px")
									  .attr("text-anchor", "middle")
									  .text(function(d) { return d.name; })
									  .style("fill-opacity", 1);

								  var link = svg.selectAll("path.link")
									  .data(links, function(d) { return d.target.id; });

								  link.enter().insert("path", "g")
									  .attr("class", "link")
									  .attr("fill","none")
									  .attr("stroke-width",1)
									  .style("stroke-opacity", 0.5)
									  .attr("stroke","#666666")
									  .attr("d", diagonal);
									}
								function click(d) {
									  if (d.children) {
										d._children = d.children;
									    d.children = null;
									    if(threadname.length>0){
									    	if(threadname.indexOf(d.name) !== -1){
									    		threadid=d._children[0].name;
													$.ajax({
														url : '../SET_THREAD_FOCUS',
														type : 'POST',
														data : {
															threadname : d.name,
															threadid : threadid
															},
														success : function(response) {
														window.location.href = "thread.jsp";
															}
														});
													}
												}
											} 
									  else {
									    d.children = d._children;
									    d._children = null;
									    if(threadname.length>0){
									    	if(threadname.indexOf(d.name) !== -1){
									    		threadid=d.children[0].name;
													$.ajax({
														url : '../SET_THREAD_FOCUS',
														type : 'POST',
														data : {
															threadname : d.name,
															threadid : threadid
															},
														success : function(response) {
														window.location.href = "thread.jsp";
															}
														});
													}
												}
											}
									update(d);
									}
							}
							function getDataForVisualization(project_id,id,obj,db){
								
								var projectdata = {
										"database" :db,
										"token" : "<%=session.getAttribute("super_token")%>",
										"project_id" : project_id
									};
									$.ajax({
										url :  "/WSG/project/wondering_area/thread/get",
										type : "POST",
										data : JSON.stringify(projectdata),
										dataType : "json",
										success : function(data, textStatus, jqXHR) {
											var json = $.parseJSON(data.obj);
											
											if(json!=null){
												for(var j = 0; j < json.length;j++){
													threadname.push(json[j].thread_name);
													wonderingarea.push(json[j].wondering_area);
													projecttitle.push(json[j].project_title);
													
												}
											var nest = d3.nest()
										    	.key(function(json) {
										            return json.project_title;
										        })
										        .key(function(json) {
										            return json.wondering_area;
										        })
										        .key(function(json) {
										            return json.thread_name;
										        })
										        .key(function(json){
							        			return json.thread_id;
							        			})
										        .entries(json);
											
											
											var nest1 = JSON.stringify(nest);
											projectData1 = nest1;
											 
											var regex = new RegExp("key", 'g');
											projectData1 = projectData1.replace(regex, 'name');
											 
											var regex1 = new RegExp("values", 'g');
											projectData1 = projectData1.replace(regex1, 'children'); 
											
											drawVisualization(projectData1,id);
											}
											else{
												var x = document.getElementById('tree_'+obj);
												x.style.display = 'none';
										        $("#btn_"+obj).text("Show wondering areas and idea threads");
										        Materialize.toast('No wondering area and idea thread available for this project.', 3500)
											}
										}
									});
					  			
								
					}
							function toggleVisualization(obj,project_id,db){
								
								    var x = document.getElementById('tree_'+obj);
								    var id="tree_"+obj;
								    if (x.style.display != 'block') {
								        x.style.display = 'block';
								        setTimeout(function(){getDataForVisualization(project_id,id,obj,db);},1000);
								        $("#btn_"+obj).text("Hide wondering areas and idea threads");
								    } else {
								        x.style.display = 'none';
								        d3.select("svg").remove();
								        $("#btn_"+obj).text("Show wondering areas and idea threads");
								    }
								}
	</script>


	<script src="../js/jspdf.min.js"></script>
	<script>
		var doc = new jsPDF();
		var specialElementHandlers = {
			'#editor' : function(element, renderer) {
				return true;
			}
		};

		$('#cmd').click(function() {
			doc.fromHTML($('#pdf_print').html(), 15, 15, {
				'width' : 170,
				'elementHandlers' : specialElementHandlers
			});
			doc.save('sample-file.pdf');
		});
	</script>



	<script src="../js/sigma.min.js"></script>
	<script src="../js/plugins/sigma.parsers.json.min.js"></script>
	<script src="../js/itm.js"></script>
	<script>
	// super talk init
	function init_super_talke_thread(){
		var projectdata = {
				"database" :'<%=session.getAttribute("localdb")%>' ,
				"token" : '<%=session.getAttribute("token")%>',
				"projectid":<%=session.getAttribute("projectid")%>
			};

			$.ajax({
						url :  "/WSG/project/thread/get",
						type : "POST",
						data : JSON.stringify(projectdata),
						dataType : "json",
						success : function(data, textStatus, jqXHR) {	
							var json = $.parseJSON(data.obj);
							console.log(json);
							if(null!=json){
								$('#thread-list').html("");
								for (var i = 0; i < json.length; i++) {
									
									// init thread checkbox list in add wondering area panel
									var html = '<p><input type="checkbox" data-id="'+json[i].id+'"  id="thread'+json[i].id+'" /><label for="thread'+json[i].id+'">'+json[i].threadfocus+'</label></p>';
									$("#thread-list").append(html);
								}
							}
								
							
						},
						error : function(jqXHR, textStatus, errorThrown) {
							//console.log(jqXHR.responseText);
						}
					});
	}
	init_super_talke_thread()
	
	$("#btn_super_talk_add").click(function(){
		
		var projectdata = {
				"database" :"itm3" ,
				"token" : '<%=session.getAttribute("token")%>',
				"question":$("#question").val(),
				"author":'<%=session.getAttribute("username")%>',
				"desc":$("#detail").val(),
				"issues":$("#know_now").val(),
				"createtime":new Date(),
				"community":"<%=session.getAttribute("community")%>",
				"cid":"<%=session.getAttribute("community_id")%>",
				"projectid":<%=session.getAttribute("projectid")%>
			};

			$.ajax({
						url :  "/WSG/supertalk/add",
						type : "POST",
						data : JSON.stringify(projectdata),
						dataType : "json",
						success : function(data, textStatus, jqXHR) {	
							//console.log("add super_talk")
							//console.log(json);
							location.reload();
							
						},
						error : function(jqXHR, textStatus, errorThrown) {
							//console.log(jqXHR.responseText);
						}
					});
		
	})
	
	

	
	
	function initSuperTalkList(buddy_project_list){
		var buddy_project =buddy_project_list		
		var json = {
				 "database" :"itm3",
				 "token" : '<%=session.getAttribute("token")%>',
		 }
		 $.ajax({
				url :  "/WSG/supertalk/get/all",
				type : "POST",
				data : JSON.stringify(json),
				dataType : "json",
				success : function(data, textStatus,
						jqXHR) {
					 if(data.code=="success"){
						 var json = $.parseJSON(data.obj);
						 for(var i in json){
							 var flag = true;
							 for(var j in buddy_project){
								 if(json[i].community_id==buddy_project[j].from_community_id&&json[i].project_id==buddy_project[j].from_project_id){
									 flag=true;
									 break;
								 }
								 if(json[i].community_id==buddy_project[j].to_community_id&&json[i].project_id==buddy_project[j].to_project_id){
									 flag=true;
									 break;
								 }
								 if(json[i].community_id=="<%=session.getAttribute("community_id")%>"&&json[i].project_id==<%=session.getAttribute("projectid")%>){
									 flag=true;
									 break;
								 }
								}
								 if(flag){
									 initSingleSuperTalk(json[i].question,json[i].id,json[i].author)
								 }
						 }
					 }
				}})
				
	}
	
	
	function initSingleSuperTalk(topic, id,author){
		var json = {
				 "database" :"itm3",
				 "token" : '<%=session.getAttribute("token")%>',
				 "sid" : id
		 }
		 $.ajax({
				url :  "/WSG/supertalk/get/numberofnote",
				type : "POST",
				data : JSON.stringify(json),
				dataType : "json",
				success : function(data, textStatus,
						jqXHR) {
					 if(data.code=="success"){
						 var json = $.parseJSON(data.obj);
						 var test ='<tr>'
								+'<td><a href="javascript:enterSuperTalk('+id+')">'+topic+'</a></td>'
								+'<td>'+author+'</td>'
								+'<td>'+json[0]['count(*)']+'</td>'
								+'</tr>';
						 $('#super-talk-list').append(test);
					 }
				}
		 })
	}
	
	function enterSuperTalk(thread_id){
		$.ajax({
			url : '../SET_CROSS_THREAD_FOCUS',
			type : 'POST',
			data : {
				threadid : thread_id,
				threadname :"",
				crossdb:'itm3'
			},
				success : function(response) {
					window.location.href = "../project/cross/thread.jsp";
				}
			});
							}
	sessionTimeOut(<%=session.getAttribute("SessionTimeOut")%>)

	</script>
</body>
</html>