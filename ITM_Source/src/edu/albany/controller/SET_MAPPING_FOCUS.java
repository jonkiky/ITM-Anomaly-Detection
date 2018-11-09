package edu.albany.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class SET_MAPPING_FOCUS
 */
@WebServlet("/SET_MAPPING_FOCUS")
public class SET_MAPPING_FOCUS extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SET_MAPPING_FOCUS() {
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
		String mappingthreadid = request.getParameter("mappingthreadid");
		String mappingthreadidtxt = request.getParameter("mappingthreadidtxt");
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		session.setAttribute("mappingthreadid", mappingthreadid);
		session.setAttribute("mappingthreadidtxt", mappingthreadidtxt);
		System.out.print(mappingthreadidtxt);
		out.print(mappingthreadid);
		out.close();
	}

}