package edu.albany.controller;


import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.X509Certificate;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Random;

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

import org.json.simple.parser.ParseException;

import edu.albany.kf.KFAPIController;
import edu.albany.kf.UserDao;
import edu.albany.monitoring.MonitoringDao;
import edu.albany.monitoring.MonitoringServices;
import edu.albany.services.Community;
import edu.albany.services.InformationServices;
import edu.albany.services.User;




/**
 * Servlet implementation class USER_LOGIN
 */
@WebServlet("/Community")
public class CommunityService extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CommunityService() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
				
				String localdb = request.getParameter("db");
				String community_id = request.getParameter("community_id");
				String role = request.getParameter("role");
				String str_id = request.getParameter("str_id");
				String kftoken=request.getParameter("kftoken");
				String kfurl=request.getParameter("kfurl");
				if(!kfurl.endsWith("/")){
					kfurl=kfurl+"/";
				}
				
		
				
				
				MonitoringDao monitor = new MonitoringDao();
				monitor.setClassName("CommunityService");
				monitor.setDomain("/Community");
				monitor.setFunctionName("doGet");
				monitor.setTime(new Date().toString());
				monitor.setMessage("Entering Community function, "
						+ "args[localdb="+localdb+","
						      + "community_id="+community_id+","
						      + "role="+role+","
						      + "str_id="+str_id+","
						      + "kftoken="+kftoken+","
						      + "kfurl="+kfurl);
				
				MonitoringServices.sentMessage(monitor);
				
				
				InformationServices services =  new InformationServices();
				
				// get user info from ITM
				List<User> UserInfo = services.getUserInfoByKfid(str_id);
				
					monitor.setMessage("get user info from ITM, UserInfo size is "+UserInfo.size());
					MonitoringServices.sentMessage(monitor);
				// get user and the communities relationship
				List<User> UserCommunityInfo = services.getUserCommunityInfo(str_id,community_id);
				
					monitor.setMessage("get UserCommunityinfo from ITM, getUserCommunityInfo  size is "+UserCommunityInfo.size());
					MonitoringServices.sentMessage(monitor);
				//get community info from ITM 
				Community communityInfo = services.getLocalComunitiesByCommunityId(community_id);
				// get User info from Localdb
					monitor.setMessage("get communityInfo from local, communityInfo  is "+communityInfo);
					MonitoringServices.sentMessage(monitor);
					
				List<User> localUserinfo = services.getlocalUserInfoByAuthorId(str_id, localdb);
				
					monitor.setMessage("get localUserinfo from local, localUserinfo  is "+localUserinfo.size());
					MonitoringServices.sentMessage(monitor);
					
				HttpSession session = request.getSession();
				String community=communityInfo.getCommunity();
				
				
				if(null!=communityInfo){
					session.setAttribute("school", communityInfo.getSchool());
					session.setAttribute("city",  communityInfo.getCity());
					session.setAttribute("country",  communityInfo.getCountry());
				}
				
				
				// validate user 
				KFAPIController kfapi = new KFAPIController();
				if(kftoken!=""&&kfurl!=""&&community_id!=""){
					monitor.setMessage("This is is a kf user");
					MonitoringServices.sentMessage(monitor);
					// if user is kf user
					UserDao user = new UserDao();
					try {
						user = kfapi.getUser(kfurl, kftoken, community_id);
					} catch (ParseException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					if(null==user){
						// invalidate Kf user. 
						monitor.setMessage("KF6 token is invalid");
						MonitoringServices.sentMessage(monitor);
						String url = "err.jsp?message='Invalidate Kf user'";
						response.sendRedirect(response.encodeURL(url.replace(" ", "%20")));
					}else{
						
						
						String itmToken = "";
						// if User is not in ITM add user info into ITM 
						if(UserInfo.isEmpty()){
							
							monitor.setMessage("this user is not registed in ITM");
							MonitoringServices.sentMessage(monitor);
							
							Random rand = new Random();
							int  n = rand.nextInt(1000) + 1;
							itmToken = getToken(n);
							
							if(role.trim().toLowerCase().equals("manager")){
								services.addUserInfoIntoITM(itmToken, "itm3", user.getUserName(), user.getFirstName(), user.getLastName(), user.getEmail(),  str_id, "3",community_id);
							}
							if(role.trim().toLowerCase().equals("writer")){
								services.addUserInfoIntoITM(itmToken, "itm3", user.getUserName(), user.getFirstName(), user.getLastName(), user.getEmail(),  str_id, "2",community_id);
							}
							if(role.trim().toLowerCase().equals("editor")){
								services.addUserInfoIntoITM(itmToken, "itm3", user.getUserName(), user.getFirstName(), user.getLastName(), user.getEmail(),  str_id, "2",community_id);
							}
							
							if(role.trim().toLowerCase().equals("reader")){
								services.addUserInfoIntoITM(itmToken, "itm3", user.getUserName(), user.getFirstName(), user.getLastName(), user.getEmail(),  str_id, "0",community_id);
							}
							
						}else{
							itmToken=UserInfo.get(0).getToken();
						}
						

						
						
						if(UserCommunityInfo.isEmpty()){
							
							monitor.setMessage("this UserCommunityInfo is null");
							MonitoringServices.sentMessage(monitor);
							
							if(role.trim().toLowerCase().equals("manager")){
								services.addUserCommunityInfoIntoITM(itmToken, "itm3", user.getUserName(), user.getLastName(), user.getFirstName(), user.getEmail(),  str_id, "3",community,localdb,community_id);
							}
							if(role.trim().toLowerCase().equals("writer")){
								services.addUserCommunityInfoIntoITM(itmToken, "itm3", user.getUserName(), user.getLastName(), user.getFirstName(), user.getEmail(),  str_id, "2",community,localdb,community_id);
							}
							if(role.trim().toLowerCase().equals("editor")){
								services.addUserCommunityInfoIntoITM(itmToken, "itm3", user.getUserName(), user.getLastName(), user.getFirstName(), user.getEmail(),  str_id, "2",community,localdb,community_id);
							}
							
							if(role.trim().toLowerCase().equals("reader")){
								services.addUserCommunityInfoIntoITM(itmToken, "itm3", user.getUserName(), user.getLastName(), user.getFirstName(), user.getEmail(),  str_id, "0",community,localdb,community_id);
							}
						}
						
						
						
						if(null==localUserinfo||localUserinfo.isEmpty()){
							monitor.setMessage("localUserinfo is null");
							MonitoringServices.sentMessage(monitor);
							if(
									role.trim().toLowerCase().equals("0")||
									role.trim().toLowerCase().equals("1")||
									role.trim().toLowerCase().equals("2")||
									role.trim().toLowerCase().equals("3"))
							{
								services.addUserInfoInToCommunity(itmToken, localdb, user.getUserName(), user.getLastName(), user.getFirstName(), user.getEmail(),  str_id, role,community_id);
							}
							
							
							// add user into the community
							
							if(role.trim().toLowerCase().equals("manager")){
								services.addUserInfoInToCommunity(itmToken, localdb, user.getUserName(), user.getLastName(), user.getFirstName(), user.getEmail(),  str_id, "3",community_id);
								role="3";
							}
							if(role.trim().toLowerCase().equals("writer")){
								services.addUserInfoInToCommunity(itmToken, localdb, user.getUserName(), user.getLastName(), user.getFirstName(), user.getEmail(),  str_id, "2",community_id);
								role="2";
							}
							if(role.trim().toLowerCase().equals("editor")){
								services.addUserInfoInToCommunity(itmToken, localdb, user.getUserName(), user.getLastName(), user.getFirstName(), user.getEmail(),  str_id, "2",community_id);
								role="2";
							}
							
							if(role.trim().toLowerCase().equals("reader")){
								services.addUserInfoInToCommunity(itmToken, localdb, user.getUserName(), user.getLastName(), user.getFirstName(), user.getEmail(),  str_id, "0",community_id);
								role="0";
								
							}

						}else{
							monitor.setMessage("localUserinfo is not null,update the user info");
							MonitoringServices.sentMessage(monitor);
							
							// if user local information exist , then update the database
							if(
									role.trim().toLowerCase().equals("0")||
									role.trim().toLowerCase().equals("1")||
									role.trim().toLowerCase().equals("2")||
									role.trim().toLowerCase().equals("3"))
							{
								services.updateUserInfoInToCommunity(itmToken, localdb,  user.getUserName(), user.getLastName(), user.getFirstName(), user.getEmail(),  str_id, role.trim().toLowerCase());
							}
							
							
							if(role.trim().toLowerCase().equals("manager")){
								services.updateUserInfoInToCommunity(itmToken, localdb,  user.getUserName(), user.getLastName(), user.getFirstName(), user.getEmail(),  str_id, "3");
								role="3";
							}
							if(role.trim().toLowerCase().equals("writer")){
								services.updateUserInfoInToCommunity(itmToken, localdb,  user.getUserName(), user.getLastName(), user.getFirstName(), user.getEmail(),  str_id, "2");
									role="2";
								
							}
							if(role.trim().toLowerCase().equals("editor")){
								services.updateUserInfoInToCommunity(itmToken, localdb,  user.getUserName(), user.getLastName(), user.getFirstName(), user.getEmail(),  str_id, "2");
										role="2";
							}
							
							if(role.trim().toLowerCase().equals("reader")){
								services.updateUserInfoInToCommunity(itmToken, localdb,  user.getUserName(), user.getLastName(), user.getFirstName(), user.getEmail(),  str_id, "0");
										role="0";
							}
						}
						
						
						session.setAttribute("SessionTimeOut", request.getSession().getMaxInactiveInterval());
						session.setAttribute("email", user.getEmail());
						session.setAttribute("role", role);
						session.setAttribute("username", user.getUserName());
						session.setAttribute("id", str_id);
						session.setAttribute("ITMDatabase", "itm3");
						session.setAttribute("token", itmToken);
						session.setAttribute("kftoken", kftoken);
						session.setAttribute("super_token","123456");
						session.setAttribute("kfURL",kfurl);
						session.setAttribute("localdb", localdb.toLowerCase());
						session.setAttribute("community", community);
						session.setAttribute("community_id", community_id);
						String url = "project/openedit.jsp?user_id="+str_id+"&community_id="+community_id+"&community="+community+"&localdb="+localdb.toLowerCase();
						response.sendRedirect(response.encodeURL(url.replace(" ", "%20")));	
						
					}
					
					
					//end if user is kf user
				}else{
					monitor.setMessage("This is is a ITM user");
					MonitoringServices.sentMessage(monitor);
					//end if user is ITM user
					// if User is not in ITM 
					if(UserInfo.isEmpty()){
						// invalidate Kf user. 
						String url = "err.jsp?message='Invalidate ITM user'";
						response.sendRedirect(response.encodeURL(url.replace(" ", "%20")));
						
					}else{
						session.setAttribute("SessionTimeOut", request.getSession().getMaxInactiveInterval());
						session.setAttribute("email", UserInfo.get(0).getEmail());
						session.setAttribute("role", role);
						session.setAttribute("username", UserInfo.get(0).getUserName());
						session.setAttribute("id", str_id);
						session.setAttribute("ITMDatabase", "itm3");
						session.setAttribute("token", UserInfo.get(0).getToken());
						//session.setAttribute("token", "123456");
						session.setAttribute("kftoken", kftoken);
						session.setAttribute("kfURL",kfurl);
						session.setAttribute("super_token","123456");
						session.setAttribute("localdb", localdb.toLowerCase());
						session.setAttribute("community", community);
						session.setAttribute("community_id", community_id);
						String url = "project/openedit.jsp?user_id="+str_id+"&community_id="+community_id+"&community="+community+"&localdb="+localdb.toLowerCase();
						response.sendRedirect(response.encodeURL(url.replace(" ", "%20")));	
					}
					

					
				}
				
		}

	
	public String getToken(int uid){
		String timeStamp = new SimpleDateFormat("yyyyMMddHHmmss").format(Calendar.getInstance().getTime());
		Random rand = new Random();
		int  n = rand.nextInt(1000) + 1;
		String token = timeStamp+String.valueOf(uid)+String.valueOf(n);
		return token;
		
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
	
		
		
	}
	
	
	


}
