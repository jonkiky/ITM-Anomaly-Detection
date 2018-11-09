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
 * Servlet implementation class SET_THREAD_FOCUS
 */
@WebServlet("/SET_CROSS_THREAD_FOCUS")
public class SET_CROSS_THREAD_FOCUS extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SET_CROSS_THREAD_FOCUS() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		String threadid = request.getParameter("threadid");
		String threadname = request.getParameter("threadname");
		InformationServices service =  new InformationServices();
		String projectname = service.getSuperTalkNameById(threadid);
		String crossdb = request.getParameter("crossdb");
		PrintWriter out = response.getWriter();

		
		session.setAttribute("cross_threadid", threadid);
		session.setAttribute("cross_threadname", threadname);
		session.setAttribute("crossdb", crossdb);
		out.print(threadid);
		out.close();
	}

}
