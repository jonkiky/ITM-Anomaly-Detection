<ul id="slide-out" class="side-nav">
			<li class="logo" style="height: 100px;"><a id="logo-container" href="#"
				class="brand-logo"><img src="/ITM3/res/itmlogo100x100.gif">
			</a></li>
			<div class="divider"></div>

			<li class="no-padding">
				<ul class="collapsible collapsible-accordion">
				<li class="bold menu_community"><a href="/ITM3/dashboard.jsp"   
						 class="collapsible-header  waves-effect waves-teal blue-grey lighten-2 active"
						style="padding: 0 30px;">Communities</a></li>
					<li class="bold menu_projects"><a href="/ITM3/project/openedit.jsp"   
						 class="collapsible-header  waves-effect waves-teal blue-grey lighten-2 active"
						style="padding: 0 30px;">Projects</a></li>

					<li class="bold in-work-space"><a id="menu_working_space" 
						class="collapsible-header  waves-effect waves-teal  in-work"
						style="padding: 0 30px;">Working  Space</a>
						<div class="collapsible-body in-work-body" style="">
							<ul>
								<li id="menu_dashboard" ><a href="/ITM3/project/ourspace/dashboard.jsp"
									style="padding: 0 50px;">Project Dashboard</a></li>
								
							</ul>
						</div></li>
					
					<li id="menu_teacher_space"  class="bold  in-teacher-space"><a id="sub_menu_teacher_space" 
						class="collapsible-header  waves-effect waves-teal in-teacher"
						style="padding: 0 30px;">Teacher Space</a>
						<div class="collapsible-body in-teacher-body" style="">
							<ul>
								<li id="menu_memeber"><a href="/ITM3/project/teacherspace/members.jsp"
									style="padding: 0 50px;">Members</a></li>
								<li id="menu_cross_project"><a href="/ITM3/project/teacherspace/crossproject.jsp"
									style="padding: 0 50px;">Cross-project Connection</a></li>
								<li id="menu_planning"><a href="/ITM3/project/teacherspace/planning.jsp"
									style="padding: 0 50px;">Planning and Reflection</a></li>
								<li id="menu_message_center"><a href="/ITM3/project/teacherspace/proposal.jsp"
									style="padding: 0 50px;">Message center</a></li>
							</ul>
						</div></li>
					
					<div class="divider"></div>

					<li class="bold out-community" id="menu_language_setting"><a href="/ITM3/language_setting.jsp"
						class="collapsible-header  waves-effect waves-teal"
						style="padding: 0 30px;">Language Setting</a></li>
					<li class="bold out-community" ><a 
						class="collapsible-header  waves-effect waves-teal"
						style="padding: 0 30px;">Profile Setting</a></li>
						
					<div class="divider"></div>

					<li class="bold out-community" ><a href="/ITM3/index.jsp"
						style="padding: 0 30px;">Logout</a></li>
				</ul>
			</li>


		</ul>
		
		<a href="#" data-activates="slide-out" class="button-collapse"
			style="display: none"><i class="material-icons">menu</i></a>
			
			
		
			<script>

	           
	           
			$(document).ready(function() {
				if('<%=session.getAttribute("projectrole")%>'!='3'){
					$("#menu_teacher_space").hide()
				}
			})
			
			
			
	 function initNavBar(){
		 var url ="/ITM3/project/ourspace/dashboard.jsp?localdb=<%=session.getAttribute("localdb")%>&community_id=<%=session.getAttribute("community_id")%>&project_id=<%=session.getAttribute("projectid")%>"
		 $("#menu_dashboard a").attr("href",url);
		 var member_url = "/ITM3/project/teacherspace/members.jsp?localdb=<%=session.getAttribute("localdb")%>&community_id=<%=session.getAttribute("community_id")%>&project_id=<%=session.getAttribute("projectid")%>"
		 $("#menu_memeber a").attr("href",member_url);
		 var cross_projecta_url = "/ITM3/project/teacherspace/crossproject.jsp?localdb=<%=session.getAttribute("localdb")%>&community_id=<%=session.getAttribute("community_id")%>&project_id=<%=session.getAttribute("projectid")%>"
		 $("#menu_cross_project a").attr("href",cross_projecta_url);
		 var plan_url = "/ITM3/project/teacherspace/members.jsp?localdb=<%=session.getAttribute("localdb")%>&community_id=<%=session.getAttribute("community_id")%>&project_id=<%=session.getAttribute("projectid")%>"
		 $("#menu_planning a").attr("href",plan_url);
		 var message_url = "/ITM3/project/teacherspace/proposal.jsp?localdb=<%=session.getAttribute("localdb")%>&community_id=<%=session.getAttribute("community_id")%>&project_id=<%=session.getAttribute("projectid")%>"
		 $("#menu_message_center  a").attr("href",message_url);
		 var project_url ="/ITM3/project/openedit.jsp?localdb=<%=session.getAttribute("localdb")%>&community_id=<%=session.getAttribute("community_id")%>&project_id=<%=session.getAttribute("projectid")%>"
		 $(".menu_projects a").attr("href",project_url);
	 }
	 initNavBar()
	 
			</script>
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			