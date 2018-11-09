<%
	
  if (null ==session || session.getAttribute("username")==null)
  {
	  response.sendRedirect("/ITM3/index.jsp");
  }
  %>