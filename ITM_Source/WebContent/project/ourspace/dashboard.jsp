<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ include file="../../validation.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--Import Google Icon Font-->
<script src="../../js/d3.v3.min.js"></script>
<script src="../../js/d3.tip.v0.6.3.js"></script>
<script src="../../js/jquery-3.1.0.js"></script>
<script src="../../js/jquery-ui.js"></script>
<script src="../../js/jquery.sessionTimeout.js"></script>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<!--Import materialize.css-->
<link type="text/css" rel="stylesheet" href="../../css/materialize.css" media="screen,projection" />
<link type="text/css" rel="stylesheet"	href="../../css/customerize.css" media="screen,projection" />
<link type="text/css" rel="stylesheet"	href="../../css/jquery-ui.css" media="screen,projection" />
<link type="text/css" rel="stylesheet"	href="../../css/dashboard.css" media="screen,projection" />

</head>
<body>
	<header>
		<%@ include file="../../header.jsp" %>
		<%@ include file="../../side_menu_hidden.jsp" %>
	</header>
		
<main>
	<div class="container">
		<div class="row">
		<br>
			<nav style="line-height:20px; height:20px; font-size: 16px;">
				<div class="nav-wrapper blue-grey" style="line-height:20px; height:20px">
					<div class="col s12">
						<a href="#!" class="white-text ">Dashboard&nbsp;&nbsp;&nbsp;</a> 
						<a href="#" onclick="enterActivity()" style="color:#dddddd">Activity Radar&nbsp;&nbsp;&nbsp;</a>
						<a href="#" id="thread_mapping" style="color:#dddddd">Thread Mapping&nbsp;&nbsp;&nbsp;</a>
					</div>
				</div>
			</nav>
			<div class="col s3" style="padding-top: 10px">
				<div class=" blue-grey lighten-5">
					<div class="blue-grey-text"
						style="height: 150px; overflow: auto">
						<table>
								<thead>
									<tr>
										<th>Goal</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td id="project_goal"></td>
									</tr>
								</tbody>
							</table>
					</div>
				</div>
			</div>
			<div class="col s4" style="padding-top: 10px">
				<div class=" blue-grey lighten-5">
					<div class=" blue-grey-text"
					style="height: 150px; overflow: auto">
						<table>
								<thead>
									<tr>
										<th>Teacher's Reminder</th>
										<th><button id="btn-add-teacher-reminder" class="btn" style="height:20px;line-height:20px"><i class="material-icons">add</i></button></th>
									</tr>
								</thead>

								<tbody id="reminder-list">
								</tbody>
							</table>
					</div>
				</div>
			</div>
			<div class="col s5" style="padding-top: 10px">
				<div class=" blue-grey lighten-5">
					<div class=" blue-grey-text"
						style="max-height: 150px;overflow-y: scroll">
							<table>
								<thead>
									<tr>
										<th>Cross-project
									Sharing Space</th>
										<th><a class="btn"  id="enterCrossProject"  style="height:20px;line-height:20px" href="#">Enter</a></th>
									</tr>
								</thead>

								<tbody id="cross_project_list" >
									<tr>
										<td style="padding: 5px 5px;"> 
											<div>Buddy projects (<span id="number_of_buddy_project">0</span>)</div>
											<div id="list_buddy_project" ></div>	
										</td>
									</tr>
									<tr>
										<td style="padding: 5px 5px;">
											<div>Super Talk topics(<span id="number_super_talks">0</span>)</div>
											<div id="list_super_talk" ></div>											
										</td>
									</tr>
									<tr>
										<td style="padding: 5px 5px;">
											<div>Journey of Thinking(<span id="number_of_jot">0</span>)</div>
											<div id="list_jot" ></div>	
											</td>
									</tr>
								</tbody>
							</table>
					</div>
				</div>
			</div>
			
		</div>
	</div>
	<div class="container" style="border: 2px #eceff1 solid">

		<div id="viz_container" >
			<p align="center">
				What Are We Researching? Our Wondering Areas and Idea Threads <a style="cursor: pointer;" id="what_is_wa_and_thread">(i)</a>
			</p>
			
		</div>
		<div>
			<i class='material-icons' id='deleted_wonderingarea_ideathread_list' style='cursor: pointer'>delete</i>
		</div>
		
	</div>
	
	
	</main>


	<!-- modal -->

	<div id="field_click_modal" class="modal">
		<div class="modal-content">
			<h5 class="center" style="padding-bottom: 10px;"
				id="click_modal_field_name">Wondering area 1</h5>
			<hr>
			<div class="container" style="padding-top: 15px;">
				<div class="row">
					<button class="btn col s3">open</button>
					<button class="btn col s3 offset-s1" style="margin-left: 70px;">edit</button>
					<button class="btn col s3 right">delete</button>
				</div>
			</div>

		</div>
	</div>

	<div id="" class="modal">
	    <div class="modal-content">
	      
	    </div>
	    <div class="modal-footer">
	      <a href="#!" class="modal-action modal_close_btn waves-effect waves-green btn-flat">Close</a>
	    </div>
  	</div>

	<div id="detail_wa_and_thread" class="modal modal-fixed-footer">
		<div class="modal-content">
			<p style="font-size: 20px">Organize your whole class inquiry work by setting up “wondering areas” and “idea threads”. Each wondering area is a major direction of inquiry. Each idea thread investigates a more specific problem or challenge related to one (or more) wondering area.  Right(Ctrl) click the project to add a wondering area (for the teacher to approve). Right(Ctrl) click a wondering area to add an idea thread. 
		</p>

		</div>
		<div class="modal-footer">
			 <a href="#!" class="modal-action modal_close_sure waves-effect waves-green btn-flat ">Close</a>
		</div>
	</div>



	<div id="thread_click_modal" class="modal">
		<div class="modal-content">
			<h5 class="center" style="padding-bottom: 10px;"
				id="click_modal_thread_name">Wondering area 1</h5>
			<hr>
			<div class="container" style="padding-top: 15px;">
				<div class="row">
					<button class="btn col s3">open</button>
					<button class="btn col s3 offset-s1" style="margin-left: 70px;">edit</button>
					<button class="btn col s3 right">delete</button>
				</div>
			</div>

		</div>
	</div>


	<div id="thread_mapping_modal" class="modal modal-fixed-footer">
		<div class="modal-content">
			<h5 class="center">Select wondering areas and threads to map</h5>
			<hr>
			<div class="container">
				<div class="row">
					<div class="col s6" id="wbox">
						<h6 class="center">Wondering Areas</h6>
						<div class="divider"></div>
					</div>
					<div class="col s6" id="tbox">
						<h6 class="center">Threads</h6>
						<div class="divider"></div>

					</div>
				</div>
			</div>

		</div>
		<div class="modal-footer">
			<a id="mapping_finish" class="modal-action modal_close_btn waves-effect waves-green btn-flat ">Start Mapping</a>
			 <a href="#!" class="modal-action modal_close_btn waves-effect waves-green btn-flat ">Cancel</a>
		</div>
	</div>


	<div id="add_field_modal" class="modal modal-fixed-footer">
		<div class="modal-content">
			<h4>Add a wondering area</h4>
			
			<div class="input-field col s12">
				<input id="wf_name" type="text" class="validate"> <label
					for="wf_name">Name</label>

			</div>
	

			<div class="chips chips-placeholder" id="area_keywords"></div>
			<div class="input-field col s12">
				<input id="why_important" type="text" class="validate"> <label
					for="why_important">Why Important?</label>
			</div>
			<div class="input-field col s12">
				<input id="questions" type="text" class="validate"> <label
					for="questions">Overaching questions</label>
			</div>
			<div class="col s12">
			<p>Add idea threads in to new area:</p>
			
			</div>
			<div class="col s12" id="thread_checkboxes"></div>
			<div class="input-field col s12">
				<input id="message" type="text" class="validate"> <label
					for="message">Message to teacher:</label>
			</div>
				<div class=" col s8 offset-s2  file-field input-field">
      <div class="btn">
        <span>Topic image</span>
        <input type="file" name="filename" >
      </div>
      <div class="file-path-wrapper">
        <input class="file-path validate" type="text" placeholder="Upload JPEG">
      </div>
      	<div id="img"></div>
    </div>
    
		</div>
		<div class="modal-footer">
			<a href="#!" id="wf_finish" class="modal-action waves-effect waves-green btn-flat ">Save</a>
			<a href="#!" class="modal_close_sure modal-action modal_close_btn waves-effect waves-green btn-flat ">Cancel</a>
		</div>
	</div>
	
	
	
	<div id="color_label_modal" class="modal modal-fixed-footer">
		<div class="modal-content">
			<h4 id="wonderingArea"></h4>
			<div class="preview"></div>
            <div class="colorpicker" style="display:block;">
                <canvas id="picker" var="1" width="300" height="300"></canvas>
            </div>
			<input type="hidden" id="wonderingAreaText">
			<input type="hidden" id="wonderingAreaId">
			<input type="hidden" id="selectedColor">
					
    
		</div>
		<div class="modal-footer">
			<a href="#!" id="color_label_finish"
				class="modal-action modal-close waves-effect waves-green btn-flat ">Save</a>
			<a href="#!" class="modal_close_sure modal-action modal_close_btn waves-effect waves-green btn-flat ">Cancel</a>
		</div>
	</div>
	
	<div id="thread_color_label_modal" class="modal modal-fixed-footer">
		<div class="modal-content">
			<h4 id="t_heading"></h4>
			<div class="preview"></div>
            <div class="colorpicker" style="display:block;">
                <canvas id="picker_thread" var="1" width="300" height="300"></canvas>
            </div>
			<input type="hidden" id="t_name">
			<input type="hidden" id="t_id">
			<input type="hidden" id="t_color">
					
    
		</div>
		<div class="modal-footer">
			<a href="#!" id="thread_color_label_finish" class="modal-action modal-close waves-effect waves-green btn-flat ">Save</a>
			<a href="#!" class="modal_close_sure modal-action modal_close_btn waves-effect waves-green btn-flat ">Cancel</a>
		</div>
	</div>

	<div id="add_thread_modal" class="modal modal-fixed-footer" style="top: 0 !important; max-height: 100%;height: 100%;bottom: 0;width:100%">
		<div class="modal-content">
			<h4>Add a New Idea Thread</h4>
			<input id="lda" type="hidden" value="false">
			<div class="input-field col s12">
				<input id="thread_name" type="text" class="validate"> <label
					for="thread_name">Name/focus:</label>
			</div>
			<div class="chips chips-placeholder" id="thread_keywords"></div>
					<textarea id="key_resource"> 
		Key resource (books/websites/videos) we
				may use
				</textarea>
			<div id="add_wf_views">
				<div class="row" id="new-note-for-kf-select-view" >
						<div class="col s12 " style="height: 30px">This new note will be saved in this idea thread and also in Knowledge Forum.</div>	
						<div class="col s8 " style="height: 30px">Select a Knowledge Forum view(s) for this note...  </div>	
						<div class="col s12 ">
							<iframe id="iFrame" src="../../thread/viewlist.jsp" style="width: 100%;"></iframe>
						</div>
							
				</div>
			</div>
			<div class="row">
			<p>This thread contributes to the following wondering area(s):</p></div>
			<div id="wf_title"></div>
		
		</div>
		<div class="modal-footer">
			
			
			<a href="#!"
				class="modal_close_sure modal-action modal_close_btn waves-effect waves-green btn-flat ">Cancel</a>
				<a href="#!" id="thread_finish"
				class="modal-action waves-effect waves-green btn-flat ">Save</a>
				<a href="#!" id="thread_lda"
				class="modal-action waves-effect waves-green btn-flat ">Get Recommendation</a>
		</div>
	</div>

	<div id="modal_close_popup" class="modal">
		<div class="modal-content">
			<h4>Do you want to give up editing?</h4>
		</div>
		<div class="modal-footer">
			<a href="#!"
				class="modal-action modal-close waves-effect waves-green btn-flat ">No</a>
			<a href="#!"
				class="modal_close_sure modal-action modal_close waves-effect waves-green btn-flat ">Yes</a>
		</div>
	</div>

	<div id="modal_edit_done" class="modal">
		<div class="modal-content">
			<h4>Add a New Idea Thread</h4>
			<div id="thread_add_panel">
			</div>
		</div>
	<div class="modal-footer">
			<a href="#!" 
				class="modal-action modal-close waves-effect waves-green btn-flat ">Save</a>
			<a href="#!"
				class="modal-action modal_close_btn waves-effect waves-green btn-flat ">Cancel</a>
		</div>
	</div>

	<div id="deleted_wonderingarea_ideathread_list_modal" class="modal modal-fixed-footer">
		  
    <div class="modal-header">
   	<div class="row">
      <ul class="tabs">
        <li class="tab col s6"><a class="active" id="wondering_area_list" href="#test1">Wondering Area</a></li>
        <li class="tab col s6"><a href="#test2"  id="idea_thread_list">Idea Thread</a></li>
      </ul>
    </div>
		  </div>
		  
		  <div class="modal-content" style="margin-top: 0px; padding-top: 0px">
		     <p id="deleted_wonderingarea_ideathread_list_content"></p>
		  </div>
		  <div class="modal-footer">
		      <a href="#!" class="modal-action modal-close waves-effect waves-green btn-flat ">Close</a>
		  </div>
  </div>
		
	
	<div id="area_info_modal" class="modal">
		<div class="modal-content" style="pointer-events: none;height:auto">
			<!-- <h4 id="wa_name"></h4> -->
			<div class="input-field col s12">
				<input id="wa_name" type="text" class="validate">  <label
					for="wa_name">Area Name:</label> 
			</div>
			<input id="area_id" type="hidden" class="validate">
			
			
			<label for="wf_keywords">Area keywords</label>
			<div class="chips chips-placeholder" id="wf_keywords"></div>
			
			<div class="input-field col s12">
				<input id="overarching_questions" type="text" class="validate"> <label
					for="overarching_questions">Overarching Questions:</label>
			</div>
			<div class="input-field col s12">
				<input id="whyimportant" type="text" class="validate"> <label
					for="whyimportant">Why Important?</label>
			</div>
			<div class="input-field col s12">
				<input id="area_message" type="text" class="validate"> <label
					for="area_message">Message to teacher:</label>
			</div>
			<div id="focus_members"></div>
			
			
		</div>
		<div class="modal-footer">
				<span ><a style="margin-left: 4px;margin-right: 4px;" class="modal-trigger modal-close waves-effect waves-green btn "
				href="#!">Close</a></span>
			<span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#!" id="area_delete_btn" style="margin-left: 4px;margin-right: 4px;" class="waves-effect waves-green btn">Delete</a> </span>
			<span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#!" style="margin-left: 4px;margin-right: 4px;"  id="area_edit_btn" data-mode="edit" class="waves-effect waves-green btn">Edit</a> </span>
			 
			
		</div>
		
		
	</div>
	
	
	<div id="add_reminder" class="modal">
		<div class="modal-content">
			<p>Add Reminder</p>
			<div class="input-field col s12">
				<input id="input-reminder-title" type="text" class="validate"> <label
					for="input-reminder-title">Title</label>

			</div>
			<div class="input-field col s12">
				<textarea id="input-reminder-content" class="materialize-textarea"></textarea>
          <label for="input-reminder-content">Content</label>
			</div>
		</div>
		<div class="modal-footer">
			<a href="#!" id="btn_add_reminder"
				class=" modal-action modal-close waves-effect waves-green btn-flat">Add</a>
			<a href="#!" id="go"
				class=" modal-action modal-close waves-effect waves-green btn-flat">Cancel</a>
		</div>
	</div>


	<div id="view_reminder" class="modal">
		<div class="modal-content">
			<h4 id="reminder-title"></h4>
			<div clss="row" id="reminder-content">
			</div>
		</div>
		<div class="modal-footer">
			<a href="#!" id="go"
				class=" modal-action modal-close waves-effect waves-green btn-flat">Cancel</a>
		</div>
	</div>
	
	
    <%@ include file="../../thread/thread_info_modal.jsp"%>
    
	<script src="../../js/sigma.min.js"></script>
	<script src="../../js/notify.js"></script>
	<script src="../../js/itm.js"></script>
	<script type="text/javascript" src="../../js/materialize.min.js"></script>
	
	<script>

	
	 // global variables
	 var localdb = getUrlParameter("localdb");
	 var community_id=getUrlParameter("community_id");
	 var isCrossProject = community_id!="<%=session.getAttribute("community_id")%>" ? true : false;
		
	 var project_id=getUrlParameter("project_id");
	 var community_name=getUrlParameter("community_name");
	 var super_token="<%=session.getAttribute("super_token")%>";
	 var token = isCrossProject?'<%=session.getAttribute("super_token")%>':'<%=session.getAttribute("token")%>';
	 var id='<%=session.getAttribute("id")%>';
	 var path =location.href
	 
	 var project_role = "<%=session.getAttribute("projectrole")%>"
	 var wondering_area_id=[];
	 var wondering_area_name=[];
	 var buddy_project_id=""
	 var project="";
	 var threadname = [];
	 var area_color = [];
	 var area = [];
	 var wonderingarea =[];
	 var area_id = [];
	 var overarching_questions = [];
	 var projecttitle =[];
	 var focusedarea = [];
	 var area_size = [];
	 var projectData1 = ''
	 var all_focused_group_memebers = [];
	 var tip;
		
	 if(isCrossProject||project_role!="3"){
			$("#btn-add-teacher-reminder").hide()
		}
	 

	 
	
	
		$(document).ready(function() {

			$("#area_delete_btn").click(function(){
				if("<%=session.getAttribute("role")%>"!="2"&&"<%=session.getAttribute("role")%>"!="3"){
					Materialize.toast('Please contact teacher to delete this wondering area !', 3000); 
					return
				}
				if(confirm("Are you sure you want to delete this wondering area?")){
					var areaInfo = {
							"database" :'<%=session.getAttribute("localdb")%>' ,
							"token" : '<%=session.getAttribute("token")%>',
							"wid" :$("#area_info_modal #area_id").val()
					}
						$.ajax({
							url :  "/WSG/project/wondering_area/del",
							type : "POST",
							data : JSON.stringify(areaInfo),
							dataType : "json",
							success : function(data, textStatus,jqXHR) {
								location.reload(true);		
							}
						})
				}
			});
			
	
		});
	
	
	
		
		console.log("<%=session.getAttribute("SessionTimeOut")%>")
		
	
		
	</script>
	<script src="../../js/project_dashboard.js"></script>
</body>