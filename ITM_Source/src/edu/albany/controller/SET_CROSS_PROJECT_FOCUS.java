package edu.albany.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import edu.albany.services.InformationServices;

/**
 * Servlet implementation class SET_PROJECT_FOCUS
 */
@WebServlet("/SET_CROSS_PROJECT_FOCUS")
public class SET_CROSS_PROJECT_FOCUS extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SET_CROSS_PROJECT_FOCUS() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String projectid = request.getParameter("projectid");
		InformationServices service =  new InformationServices();
		HttpSession session = request.getSession();
		String crossdb = request.getParameter("crossdb");
		String projectname = service.getProjectNameById(projectid, crossdb);
		PrintWriter out = response.getWriter();
		InformationServices services =  new InformationServices();
		
		
		
		session.setAttribute("cross_projectid", projectid);
		session.setAttribute("cross_projectname", projectname);
		session.setAttribute("crossdb", crossdb);
		out.print(projectid);
		out.close();
	}

}
