<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="validation.jsp" %>
<!DOCTYPE html>
<html>
<head>
<!--Import Google Icon Font-->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<!--Import materialize.css-->
<link type="text/css" rel="stylesheet" href="css/materialize.css"
	media="screen,projection" />

<!--Let browser know website is optimized for mobile-->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta charset="UTF-8">

</head>

<body>

		<header>
		<%@ include file="header.jsp" %>

		<%@ include file="side_menu_hidden.jsp" %>
	
	</header>

	<main>
	<div class="container">
	 Language Setting
	
	</div>
	</main>



	<!--Import jQuery before materialize.js-->
	<%@ include file="javascript.jsp" %>
	<script type="text/javascript">
	
	$(".button-collapse").sideNav();
	$("#show_slide").click(function() {
		$('.button-collapse').sideNav('show');
	});
	$("#page_title").html("Language Setting")
	
	</script>
</body>
</html>