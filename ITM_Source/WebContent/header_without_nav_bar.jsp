<style>
.collapsible-body {
	padding: 0px !important;
}

.chips .input {
	width: 200px !important;
}
</style>

<nav  class="  blue-grey">
		
					<div  style="float:left;width:100px" >
						<span style="float:right;"><img style="height: 49px;" src="/ITM3/res/itmlogo100x100.gif"></span>
					</div>
					<div style="float:left" id="page_title" style="width:300px" >
						&nbsp;&nbsp;&nbsp;Community
					</div>
					<div style="float:right">
					<%
						Object username = session.getAttribute("username");
						if(null==username){
							username="Guest";
						}
					
					%>
						<h5 style="font-size:14px;">Welcome <span id="user-name"><%=username%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><br>
						<a href="/ITM3/index.jsp"
						style="padding: 0 30px;">Logout</a></h5>
						
						
					</div>
				
			</nav>
		<!-- 
			<div style="float:right">
						<a class="dropdown-button" href="#!"
							data-activates="dropdown1">Language <i
								class="material-icons right">arrow_drop_down</i></a>
					</div>
		
		
		 -->	