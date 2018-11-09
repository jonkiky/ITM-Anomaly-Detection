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
<%@ include file="../../javascript.jsp" %>
<script src="../../js/jquery-3.1.0.js"></script>
<script src="../../js/jquery-ui.js"></script>
<script src="../../js/jquery.sessionTimeout.js"></script>
<script type="text/javascript" src="../../js/materialize.js"></script>
<script src="../../js/itm.js"></script>
	<script type="text/javascript" src="../../js/materialize.min.js"></script>
		<script src="../../js/notify.js"></script>
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
			
			<div class="input-field col s8 offset-s2" style="padding-top: 10px">
				<input value="" id="title" type="text" class="validate"> <label
					for="title">Project title:</label>
			</div>
			<div class="input-field col s8 offset-s2"> School Year</div> 
			<div class="input-field col s4 offset-s2">
				<select id="fromYear">
					<option value="2013">2013</option>
					<option value="2014">2014</option>
					<option value="2015">2015</option>
					<option value="2016">2016</option>
					<option value="2017">2017</option>
					<option value="2018">2018</option>
					<option value="2019">2019</option>
					<option value="2020">2020</option>
					<option value="2021">2021</option>
					<option value="2022">2022</option>
					<option value="2023">2023</option>
					<option value="2024">2024</option>
				</select> <label>From Year</label>
				
			</div>
			
			<div class="input-field col s4">
				<select id="fromMonth">
					<option value="1">January</option>
					<option value="2">February</option>
					<option value="3">March</option>
					<option value="4">April</option>
					<option value="5">May</option>
					<option value="6">June</option>
					<option value="7">July</option>
					<option value="8">August</option>
					<option value="9">September</option>
					<option value="10">October</option>
					<option value="11">November</option>
					<option value="12">December</option>
				</select> <label>Month</label>
			</div>
			
			<div class="input-field col s4 offset-s2">
				<select id="toYear">
					<option value="2013">2013</option>
					<option value="2014">2014</option>
					<option value="2015">2015</option>
					<option value="2016">2016</option>
					<option value="2017">2017</option>
					<option value="2018">2018</option>
					<option value="2019">2019</option>
					<option value="2020">2020</option>
					<option value="2021">2021</option>
					<option value="2022">2022</option>
					<option value="2023">2023</option>
					<option value="2024">2024</option>
				</select> <label>To Year</label>
			</div>
				<div class="input-field col s4">
				<select id="toMonth">
					<option value="1">January</option>
					<option value="2">February</option>
					<option value="3">March</option>
					<option value="4">April</option>
					<option value="5">May</option>
					<option value="6">June</option>
					<option value="7">July</option>
					<option value="8">August</option>
					<option value="9">September</option>
					<option value="10">October</option>
					<option value="11">November</option>
					<option value="12">December</option>
				</select> <label>Month</label>
			</div>
			
			<div class="input-field col s8 offset-s2">
				<input value="" id="goal" type="text" class="validate"> <label
					for="goal">Project goal:</label>
			</div>
				<div class=" col s8 offset-s2  file-field input-field">
      <div class="btn">
        <span>Project Logo</span>
        <input type="file" name="filename" >
      </div>
      <div class="file-path-wrapper">
        <input class="file-path validate" type="text" placeholder="Upload JPEG">
      </div>
      	<div id="img"></div>
    </div>
			
			<div class="input-field col s8 offset-s2 ">
			
				<select multiple id="teacher">
				</select> 
				<label>Add Teachers</label>
			</div>

			<div class="input-field col s8 offset-s2">
				<select multiple id="select-grade">
					<option value="" disabled selected>Grade Level</option>
					<option value="15">Other</option>
				</select> <label>Grade Level</label>
			</div>
			
			<div class="input-field col s8 offset-s2">
				<select multiple id="area">
					<optgroup label="Language Arts">
						<option value="1">Writing</option>
						<option value="2">Reading</option>
						<option value="3">Speaking and Listening</option>
						<option value="4">Study Skills</option>
					</optgroup>
					<optgroup label="Science">
						<option value="5">Earth and Space Systems</option>
						<option value="6">Life Sciences: Boilogy</option>
					</optgroup>
				</select> <label>Curriculum area:</label>
			</div>
			
			<div class="input-field col s8 offset-s2" style="padding-top: 10px">
				<input value="" id="mcode" type="text" class="validate"> <label
					for="title">Teacher Code</label>
			</div>
			<div class="input-field col s8 offset-s2" style="padding-top: 10px">
				<input value="" id="wcode" type="text" class="validate"> <label
					for="title">Student Code</label>
			</div>
			<div class="input-field col s8 offset-s2" style="padding-top: 10px">
				<input value="" id="acode" type="text" class="validate"> <label
					for="title">Visitor Code</label>
			</div>
			<div class="input-field col s8 offset-s2" style="padding-top: 10px">
			<button class="btn waves-effect waves-light" style="float:right;margin-left:20px;"
				type="submit" name="action" data-mode="new" id="create-submit">
				Save
			</button>
			<button class="btn waves-effect waves-light" style="float:right" onclick="goBack()"
				type="submit" name="action" >
				Cancel 
			</button>
			</div>
		</div>
	
	
	</div>
	</main>





	<script type="text/javascript">
	function goBack() {
	    window.history.back();
	}
	
	var project_id = getUrlParameter("project_id");
	var localdb =getUrlParameter("localdb");
	var community_id = getUrlParameter("community_id");
	
	var project=""
	$(window).on('load', function() {
		
		$(".button-collapse").sideNav();
		$("#show_slide").click(function() {
			$('.button-collapse').sideNav('show');
		});
		
		console.log(project_id)
		
		if(null!=project_id){
			var pid = project_id;
			var json =JSON.parse(localStorage.projects);
			project = json[pid]
			var titleHtml ='Edit Project '+project.title
			$("#page_title").html(titleHtml)
				
		}
		
		function initFromYear(){
			 $('#fromYear').find('option[value="'+project.school_year_from.split("/")[0]+'"]').prop('selected', true);
			 $("#fromYear").trigger('contentChanged');
		}
		
		function initToYear(){
			 $('#toYear').find('option[value="'+project.school_year_to.split("/")[0]+'"]').prop('selected', true);
			 $("#toYear").trigger('contentChanged');
		}
		
		function initFromMonth(){
			 $('#fromMonth').find('option[value="'+project.school_year_from.split("/")[1]+'"]').prop('selected', true);
			 $("#fromMonth").trigger('contentChanged');
		}
		
		function initToMonth(){
			 $('#toMonth').find('option[value="'+project.school_year_to.split("/")[1]+'"]').prop('selected', true);
				
			 $("#toMonth").trigger('contentChanged');
		}
		
		function initArea(){
			$("#area").empty().html(' ');
			var json =JSON.parse(localStorage.curriculums);
			   if(null!=json[0].id){
				   // find level 1 
				   var level1=[]
				   for( var i in json){
					   if(json[i].parent_id==0){
						   	if(null == level1[json[i].id]){ // level 1 have not be init
						   		level1[json[i].id]={'parent':json[i].name,'child':[]}
						   	}else{
						   	// level 1 have be inited
						   		level1[json[i].id]["parent"] =json[i].name
						   	}
							  
					   }else{
						   // if it is level2 element 
							if(null == level1[json[i].parent_id]){ // if it is parent have not be initial
								level1[json[i].parent_id]={'parent':'','child':[{'id':json[i].id,'title':json[i].name}]}
							}else{
								level1[json[i].parent_id]["child"].push({'id':json[i].id,'title':json[i].name})
							}					   
					   }

				   }
				   for(var i in level1){
					   level1[i]
					   var html  = '<optgroup label="'+level1[i].parent+'">'
					   html=html+'<option  value="'+i+'">'+level1[i]["parent"]+'[parent]</option>'
					   var html=""
					   for (var j in level1[i]["child"]){
						   html=html+'<option value="'+level1[i]["child"][j]["id"]+'">'+level1[i]["child"][j]["title"]+'</option>'
					   }
					   html=html+'</optgroup>'
					   $("#area").append(html)
				   }
				   if(null!=project||""!=project||null!=project.curriculum||""!=project.curriculum){
					   for(var i in project.curriculum){
						   $('#area').find('option[value="'+project.curriculum[i].curriculum_area_id+'"]').prop('selected', true);
					   }
				   }
				   $("#area").trigger('contentChanged');
			   }
		}
			
		function initGrades(){
			  var $selectDropdown = 
			      $("#select-grade")
			        .empty()
			        .html(' ');
			// init grade options
			var json =JSON.parse(localStorage.grades);
			   if(null!=json[0].id){
				   for( var i in json){
					   $selectDropdown.append(
					   $("<option></option>")
				        .attr("value",json[i].id)
				        .text(json[i].title)
				        )
					  
				   }
				   if(null!=project||""!=project||null!=project.grade||""!=project.grade){
					   for(var i in project.grade){
						   $('#select-grade').find('option[value="'+project.grade[i].grade_id+'"]').prop('selected', true);
					   }
				   }
				   $selectDropdown.trigger('contentChanged');
			   }
		}
		function initUsers(){
			$("#teacher").empty().html(' ');
			var json =JSON.parse(localStorage.users);
			   if(null!=json[0].id){
					   for( var i in json){
						   if(null!=json[i].username){
						   $("#teacher").append(
						   $("<option></option>")
					        .attr("value",json[i].str_id)
					        .text(json[i].first_name+" "+json[i].last_name)
					        )
						  
					   }
					   
				   }
					   if(null!=project||""!=project||null!=project.authors||""!=project.authors){
						   for(var i in project.authors){
							   $('#teacher').find('option[value="'+project.authors[i].author_id+'"]').prop('selected', true);
						   }
					   }
					   $("#teacher").trigger('contentChanged');
			}
		}
		
		
		function initInput(){
			if(project.logo!=""||project.logo!="@logo"){
				$("#img").html("")
		    	var html ='<img class="materialboxed" width="400" src="'+project.logo+'">'
		    	$("#img").html(html)
			}
			
			$("#title").val(project.title);
			$("#goal").val(project.goal);
			$("#mcode").val(project.access_code_manage);
			$("#wcode").val(project.access_code_read_write);
			$("#acode").val(project.access_code_read_only);
			
		}
		
		
		function init(){
			initArea()
			initGrades()
			initUsers()
			initFromYear()
			initToYear()
			initFromMonth()
			initFromMonth()
			initInput()
		}
		
		init()
		
		
		  $('select').on('contentChanged', function() {
    				 // re-initialize (update)
    				 
   					 $(this).material_select();
  			});
		
		
			
			$('select').material_select();
			  $('.materialboxed').materialbox();

			 $(document).on('change', '.file-field input[type="file"]', function () {
			      var file_field = $(this).closest('.file-field');
			      var path_input = file_field.find('input.file-path');
			      var files      = $(this)[0].files;
			      var file_names = [];
			      for (var i = 0; i < files.length; i++) {
			        file_names.push(files[i].name);
			      }
			      path_input.val(file_names.join(", "));
			      path_input.trigger('change');
			      uploadFile(files)
			 });
			 
			 function uploadFile(files){
				 var fd = new FormData();
				 fd.append('uploadFile',files[0])
					  $.ajax({
					    type: 'post',
					    url: '/IFS/uploadFile',
					    data: fd,
		                processData: false,
		                cache: false,
		                contentType:false,
					    success: function (data) {
					      // do something
					      console.log(data);
                            var imageURL = window.location.origin
                            var json = imageURL+"/IFS/resources/data/"+$.trim((data.obj).split("@")[2])
//                            var json = "/IFS/resources/data/"+$.trim((data.obj).split("@")[2])
					    	$("#img").html("")
					    	var html ='<img class="materialboxed" width="400" src="'+json+'">'
					    	$("#img").html(html)
					    }
					  });
			 }
		
	})
	
	
	
			function add_project_author(projectId,authorId){
					var jsondata = {
							"database" :localdb ,
							"token" : '<%=session.getAttribute("token")%>',
							"projectid":projectId,
							"authorid":authorId,
							"usertype":'<%=session.getAttribute("role")%>',
							"userrole":"teacher"
			 		}
			 		
			 		$.ajax({
						url :  "/WSG/project/member/add/byauthor",
						type : "POST",
						data : JSON.stringify(jsondata),
						dataType : "json",
						success : function(data, textStatus, jqXHR) {
							console.log("add project author success");
						},
						error : function(jqXHR, textStatus, errorThrown) {
							console.log(jqXHR.responseText);
						}})	
			 	}
			 	
			 	
			 	function add_project_member(projectId,authorId){
			 		var jsondata = {
							"database" :localdb,
							"token" : '<%=session.getAttribute("token")%>',
							"projectid":projectId,
							"authorid":authorId,
							"usertype":'<%=session.getAttribute("role")%>',
							"userrole":"student"
			 		}
			 		
			 		$.ajax({
						url :  "/WSG/project/member/add/byauthor",
						type : "POST",
						data : JSON.stringify(jsondata),
						dataType : "json",
						success : function(data, textStatus, jqXHR) {
							console.log("add project author success");
						},
						error : function(jqXHR, textStatus, errorThrown) {
							console.log(jqXHR.responseText);
						}})
			 	}
			 	
			 	
			 	function add_project_grade(projectId,gradeId){
			 		var jsondata = {
							"database" :localdb ,
							"token" : '<%=session.getAttribute("token")%>',
							"projectId":projectId,
							"gradeId":gradeId
			 		}
			 		
			 		$.ajax({
						url :  "/WSG/project/grade/add",
						type : "POST",
						data : JSON.stringify(jsondata),
						dataType : "json",
						success : function(data, textStatus, jqXHR) {
							console.log("add project grade success");
						},
						error : function(jqXHR, textStatus, errorThrown) {
							console.log(jqXHR.responseText);
						}})
			 	}
			 
			 	function add_project_curriculum(projectId,areaid){
			 		var jsondata = {
							"database" :localdb,
							"token" : '<%=session.getAttribute("token")%>',
							"projectId":projectId,
							"areaid":areaid
			 		}
			 		
			 		$.ajax({
						url :  "/WSG/project/curriculum/add",
						type : "POST",
						data : JSON.stringify(jsondata),
						dataType : "json",
						success : function(data, textStatus, jqXHR) {
							console.log("add project grade success");
						},
						error : function(jqXHR, textStatus, errorThrown) {
							console.log(jqXHR.responseText);
						}})
			 	}
			 	

	$("#create-submit").click(function() {
		if(
 				$("#acode").val()==$("#wcode").val()||
 				$("#wcode").val()==$("#mcode").val()||
 				$("#mcode").val()==$("#acode").val()){
 			
 			Materialize.toast('The codes should not be same to each other. ', 4000)
 			return
 		}
		// edit project
		if(null!=project_id){
			var pid = project_id;
			var json =JSON.parse(localStorage.projects);
			project = json[pid]
			
		}
		if(""!=project){
			var jsondata = {
					"database" :localdb,
					"token" : '<%=session.getAttribute("token")%>',
					"projectid":project_id,
	 		}
	 		
			// del project grade
			$.ajax({
						url :  "/WSG/project/grade/del/all",
						type : "POST",
						data : JSON.stringify(jsondata),
						dataType : "json",
						success : function(data, textStatus, jqXHR) {
							if(data.code=="success"){
								
								// add project grade
								if($("#select-grade").val()!=""){
									var gradeIdes= $("#select-grade").val()
									for(var i in gradeIdes){
										add_project_grade(project_id,gradeIdes[i])
									}
								}
							}
						},
						error : function(jqXHR, textStatus, errorThrown) {
							console.log(jqXHR.responseText);
						}})
			// del project teacher
				$.ajax({
						url :  "/WSG/project/author/del/all",
						type : "POST",
						data : JSON.stringify(jsondata),
						dataType : "json",
						success : function(data, textStatus, jqXHR) {
							if(data.code=="success"){
								
								// add project teacher
								if($("#teacher").val()!=""){
									var teacherIds= $("#teacher").val()
									for(var i in teacherIds){
										add_project_author(project_id,teacherIds[i])
									}
								}
								
								
							}
						},
						error : function(jqXHR, textStatus, errorThrown) {
							console.log(jqXHR.responseText);
						}})
			// del project area
			$.ajax({
						url :  "/WSG/project/curriculum/del/all",
						type : "POST",
						data : JSON.stringify(jsondata),
						dataType : "json",
						success : function(data, textStatus, jqXHR) {
							if(data.code=="success"){
								
								// add project area
								if($("#area").val()!=""){
									var areaIdes= $("#area").val()
									for(var i in areaIdes){
										add_project_curriculum(project_id,areaIdes[i])
									}
								}
								
								
							}
						},
						error : function(jqXHR, textStatus, errorThrown) {
							console.log(jqXHR.responseText);
						}})
			
		
			// update project info
			
			
				var jsondata = {
							"database" :localdb,
							"token" : '<%=session.getAttribute("token")%>',
							"title" : $("#title").val().replace(/'/g,"\\\'").replace(/"/g,"\\\""),
							"logo" : ($(".materialboxed").attr("src")=="")?"":$(".materialboxed").attr("src"),
							"fromyear" : $("#fromYear option:selected").text()+"/"+$("#fromMonth option:selected").val(),
							"toyear" : $("#toYear option:selected").text()+"/"+$("#toMonth option:selected").val(),
							"rcode" :$("#acode").val(),
							"wcode" :$("#wcode").val(),
							"mcode" : $("#mcode").val(),
							"buddy_project_accept" : -1,
							"goal" : ($("#goal").val()=="")?"":$("#goal").val().replace(/'/g,"\\\'").replace(/"/g,"\\\""),
							"project_modify_time":new Date(),
							"projectid":project_id,
						};
			 		$.ajax({
						url :  "/WSG/project/update",
						type : "POST",
						data : JSON.stringify(jsondata),
						dataType : "json",
						success : function(data, textStatus, jqXHR) {
							if(data.code=="success"){
								$.notify('Editing project is successful', 'success');
							
								var jsondata = {
										"database" :localdb,
										"token" : '<%=session.getAttribute("token")%>',
										"projectid":project_id,
									};
						 		$.ajax({
									url :  "/WSG/project/get/byid",
									type : "POST",
									data : JSON.stringify(jsondata),
									dataType : "json",
									success : function(data, textStatus, jqXHR) {
										if(data.code=="success"){
											updateBuddyProject();
										 }else{
											 console.log("get project by id fails")
											 	sleepFor(3000)
											 window.history.back();
										 }
										}
									})
								}
							}
						})
				
					
						
			
		}
	
	});
	
	
	function updateBuddyProject(){
		var grade="";
		if($("#select-grade").val()!=""){
			var gradeIdes= $("#select-grade").val()
			for(var i in gradeIdes){
				grade+=gradeIdes[i]+","
			}
		}
		
		grade=grade.substring(0,grade.length-1)
		var curriculumInfo="";
		if($("#area").val()!=""){
			var areaIdes= $("#area").val()
			var curriculums =JSON.parse(localStorage.curriculums);
			for(var i in areaIdes){
				curriculumInfo+=curriculums[areaIdes[i]].name+","
			}
		}
		
		curriculumInfo=curriculumInfo.substring(0,curriculumInfo.length-1)
		
		var authorsInfo="";
		if($("#teacher").val()!=""){
			var teacherIds= $("#teacher").val()
			var teacher_json =JSON.parse(localStorage.users);
			for(var i in teacherIds){
				for(var j in teacher_json){
					if(teacher_json[j].str_id==teacherIds[i]){
						authorsInfo+=teacher_json[j].first_name+" "+teacher_json[j].last_name+",";
						break;
					}
				}
			}
		}
		
		authorsInfo=authorsInfo.substring(0,authorsInfo.length-1)
		
		var json =JSON.parse(localStorage.projects);
		project = json[project_id]
		
		// if this project is a buddy projec, then the buddy project need to be updated as well. 
			var jsondata = {
					"database" :'itm3' ,
					"token" : '20171029163219826664',
					"pid":project_id,
					"cid":community_id,
					"title":$("#title").val().replace(/'/g,"\\\'").replace(/"/g,"\\\""),
					"goalInfo":($("#goal").val()=="")?"":$("#goal").val().replace(/'/g,"\\\'").replace(/"/g,"\\\""),
					"gradeInfo":grade,
					"areaInfo":curriculumInfo.replace(/"/g,"\\\"").replace(/'/g,"\\\'"),
					"teacherInfo":authorsInfo,
					"logoInfo":($(".materialboxed").attr("src")=="")?"":$(".materialboxed").attr("src")
				};
		$.ajax({
			url :  "/WSG/all_buddy_project/update",
			type : "POST",
			data : JSON.stringify(jsondata),
			dataType : "json",
			success : function(data, textStatus, jqXHR) {
				if(data.code=="success"){
					
					sleepFor(2000)
					 window.history.back();
					
				 }else{
					 console.log("get project by id fails")
					 	sleepFor(3000)
					 window.history.back();
				 }
				}
			})
		
	
	}
	
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