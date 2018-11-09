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
<!--Let browser know website is optimized for mobile-->
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
			<div class="col s12" style="padding-top: 10px">
				<p
					style="padding-left: 20px; border: solid 5px; border-color: #78909c; height: 300px;">
					<br> <br> Write in Google Doc <br> <br> <br>
					The "big ideas" (main concepts, principles, and processes) to be
					learned: <br> Overarching process of inquiry and timeline
				</p>
				<p style="padding-left: 20px; border: solid 5px; border-color: #78909c; height: 300px;">
					<br> <br> Upload reflection videos or other attachments <br> <br> <br>
					Points of reflection<br>
					· How I design and facilitat this inquiry:<br>
					· Productive moments and activities:<br>
					· Opportunities for future improvements:<br>
				</p>
			</div>
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


	<!--Import jQuery before materialize.js-->
<%@ include file="../../javascript.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {

			if(""!='<%=session.getAttribute("projectid")%>'){
				var project_id = <%=session.getAttribute("projectid")%>;
				var json =JSON.parse(localStorage.projects);
				project = json[project_id]
			}
			$("#page_title").html(project.title+"'s Planning and Reflection")
			$(".button-collapse").sideNav();
			$("#show_slide").click(function(){
				$('.button-collapse').sideNav('show');
			});

			$('.collection').delegate('a', 'click', function() {
				window.location.href = "../thread/open.html";
			});
			//        $(".collection a").click(function(){
			////            $('#modal1').openModal();
			//            window.location.href = "../thread/open.html";
			//        });

			$("#go").click(function() {

			});
		});
		
		$(".side-nav").find(".blue-grey").removeClass('blue-grey')
		$(".side-nav").find(".active").removeClass('active')
		$(".side-nav").find(".show").removeClass('show')

		$(".in-teacher-space").addClass("active blue-grey lighten-2 ")
		$(".in-teacher-space-body").addClass("show")
		$(".in-teacher").addClass("active")
	</script>
</body>
</html>