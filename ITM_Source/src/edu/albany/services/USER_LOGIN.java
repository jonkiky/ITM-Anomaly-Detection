package edu.albany.services;


import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.X509Certificate;
import java.util.List;

import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;




/**
 * Servlet implementation class USER_LOGIN
 */
@WebServlet("/USER_LOGIN")
public class USER_LOGIN extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public USER_LOGIN() {
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
		String email = request.getParameter("email");
		String pwd = request.getParameter("pwd");
		PrintWriter out = response.getWriter();
		
		InformationServices userDao =  new InformationServices();
		// get user info from ITM.user
		List<User> info = userDao.getUserInfo(email, pwd);
		if(info.isEmpty()){
			// if is a invalid user 
			response.sendRedirect(response.encodeURL("index.jsp?flag=fails"));	
		}else{
			
			HttpSession session = request.getSession();
			session.setAttribute("cross_id", info.get(0).getId());
			String username = info.get(0).getUserName();
			String token= info.get(0).getToken();
			session.setAttribute("pwd", pwd);
			session.setAttribute("email", email);
			String url =response.encodeURL("dashboard.jsp?username="+username+"&email="+email+"&token="+token);
			response.sendRedirect(url);	
			
		}
		
	}
	
	
	


}
