package edu.albany.kf;


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
import javax.ws.rs.core.MultivaluedMap;

import org.apache.commons.io.IOUtils;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;
import com.sun.jersey.api.client.config.DefaultClientConfig;
import com.sun.jersey.api.json.JSONConfiguration;
import com.sun.jersey.client.urlconnection.HTTPSProperties;
import com.sun.jersey.core.util.MultivaluedMapImpl;

import edu.albany.monitoring.MonitoringDao;
import edu.albany.monitoring.MonitoringServices;
import edu.albany.services.Community;
import edu.albany.services.InformationServices;
import edu.albany.services.User;







/**
 * Servlet implementation class USER_LOGIN
 */

@WebServlet("/kf_project")
public class login_for_KF extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public login_for_KF() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
				// TODO Auto-generated method stub
	}
	
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// do check if the user is a valid user
		String url = request.getParameter("kf_url");
		if(!url.endsWith("/")){
			url=url+"/";
		}
		
	
		
		
		String token = request.getParameter("token");
		String community_id = request.getParameter("community_id");
		
		
		MonitoringDao monitor = new MonitoringDao();
		monitor.setClassName("login_for_KF");
		monitor.setDomain("/kf_project");
		monitor.setFunctionName("doPost");
		monitor.setTime(new Date().toString());
		monitor.setMessage("Entering Community function, "
				+ "args[url="+url+","
				      + "community_id="+community_id+","
				      + "token="+token+","
				      + "community_id="+community_id+","
				     );
		
		MonitoringServices.sentMessage(monitor);
		
		
		InformationServices services =  new InformationServices();
		String localdb = services.getLocaldbByCommunityId(community_id);
		
		
		
		
		if(null==localdb){
			// this community has not registed into ITM3 then go to error message
			response.sendRedirect(response.encodeURL("err.jsp?message=\"community has no been registered into ITM3.\""));	
		}
		try {
			monitor.setMessage("get localdb by community_id localdb is "+localdb);
			MonitoringServices.sentMessage(monitor);
			
			User user = checkUser(url,token,community_id);
			
			
			if(null!=user){// if it is a vaild user
				
				
				
				String str_id = user.getStr_id();
				String role=user.getType();
				String community =user.getCommunity();
				
				monitor.setMessage("Check user information, user is a valid KF user "
						+ "args[str_id="+str_id+","
						      + "role="+role+","
						      + "community="+community+","
						     );
				
				MonitoringServices.sentMessage(monitor);
				
				// get user info 
				List<User> UserInfo = services.getUserInfoByKfid(str_id);
				// get user and the communities relationship
				List<User> UserCommunityInfo = services.getUserCommunityInfo(str_id,community_id);
				//get user info from ITM 
				Community communityInfo = services.getLocalComunitiesByCommunityId(community_id);
				
				HttpSession session = request.getSession();
				if(null!=communityInfo){
					session.setAttribute("school", communityInfo.getSchool());
					session.setAttribute("city",  communityInfo.getCity());
					session.setAttribute("country",  communityInfo.getCountry());
				}
				
				
				String itmToken = "";
				if(UserInfo.isEmpty()){ // the user info not registered in ITM
					
					monitor.setMessage("User are not registered in ITM ");
					MonitoringServices.sentMessage(monitor);
					
					Random rand = new Random();
					int  n = rand.nextInt(1000) + 1;
					itmToken = getToken(n);
					if(role.trim().toLowerCase().equals("manager")){
						services.addUserInfoIntoITM(itmToken, "itm3", user.getUserName(), user.getLastName(), user.getFirstName(), user.getEmail(), str_id, "3",community_id);
					}
					if(role.trim().toLowerCase().equals("writer")){
						services.addUserInfoIntoITM(itmToken, "itm3", user.getUserName(), user.getLastName(), user.getFirstName(), user.getEmail(), str_id, "2",community_id);
							}
					if(role.trim().toLowerCase().equals("editor")){
						services.addUserInfoIntoITM(itmToken, "itm3", user.getUserName(), user.getLastName(), user.getFirstName(), user.getEmail(), str_id, "2",community_id);
											}
					
					if(role.trim().toLowerCase().equals("reader")){
						services.addUserInfoIntoITM(itmToken, "itm3", user.getUserName(), user.getLastName(), user.getFirstName(), user.getEmail(), str_id, "0",community_id);
									}
					
				}else{
					itmToken=UserInfo.get(0).getToken();
				}
				
				
				if(UserCommunityInfo.isEmpty()){  // the user's community info has not been registered in user_community
					monitor.setMessage("User community infomation are not  registered in ITM ");
					MonitoringServices.sentMessage(monitor);
					if(role.trim().toLowerCase().equals("manager")){
						services.addUserCommunityInfoIntoITM(itmToken, "itm3", user.getUserName(), user.getLastName(), user.getFirstName(), user.getEmail(), str_id, "3",user.getCommunity(),localdb,community_id);
					}
					if(role.trim().toLowerCase().equals("writer")){
						services.addUserCommunityInfoIntoITM(itmToken, "itm3", user.getUserName(), user.getLastName(), user.getFirstName(), user.getEmail(), str_id, "2",user.getCommunity(),localdb,community_id);
					}
					if(role.trim().toLowerCase().equals("editor")){
						services.addUserCommunityInfoIntoITM(itmToken, "itm3", user.getUserName(), user.getLastName(), user.getFirstName(), user.getEmail(), str_id, "2",user.getCommunity(),localdb,community_id);
					}
					
					if(role.trim().toLowerCase().equals("reader")){
						services.addUserCommunityInfoIntoITM(itmToken, "itm3", user.getUserName(), user.getLastName(), user.getFirstName(), user.getEmail(), str_id, "0",user.getCommunity(),localdb,community_id);
							
					}
					
				}
				
				List<User> info = services.getlocalUserInfoByAuthorId(str_id, localdb);
				
				if(info.isEmpty()){
					monitor.setMessage("No user's  information at localdb, then add user info str_id="+str_id);
					MonitoringServices.sentMessage(monitor);
					
						// the user info have not been registed in local community
						if(
								role.trim().toLowerCase().equals("0")||
								role.trim().toLowerCase().equals("1")||
								role.trim().toLowerCase().equals("2")||
								role.trim().toLowerCase().equals("2"))
						{
							services.addUserInfoInToCommunity(itmToken, localdb,  user.getUserName(), user.getLastName(), user.getFirstName(),   user.getEmail(),  str_id, role,community_id);
						}
						if(role.trim().toLowerCase().equals("manager")){
							services.addUserInfoInToCommunity(itmToken, localdb,  user.getUserName(), user.getLastName(), user.getFirstName(), user.getEmail(),  str_id, "3",community_id);
							role="3";
						}
						if(role.trim().toLowerCase().equals("writer")){
							services.addUserInfoInToCommunity(itmToken, localdb,  user.getUserName(), user.getLastName(), user.getFirstName(), user.getEmail(),  str_id, "2",community_id);
							role="2";
							
						}
						if(role.trim().toLowerCase().equals("editor")){
							services.addUserInfoInToCommunity(itmToken, localdb,  user.getUserName(), user.getLastName(), user.getFirstName(), user.getEmail(),  str_id, "2",community_id);
							role="2";
						}
						
						if(role.trim().toLowerCase().equals("reader")){
							services.addUserInfoInToCommunity(itmToken, localdb,  user.getUserName(), user.getLastName(), user.getFirstName(), user.getEmail(),  str_id, "0",community_id);
							role="0";
						}
						
						session.setAttribute("super_token", "123456");
						session.setAttribute("username", user.getUserName());
						session.setAttribute("fname", user.getFirstName());
						session.setAttribute("lname", user.getLastName());
						session.setAttribute("SessionTimeOut", request.getSession().getMaxInactiveInterval());
						session.setAttribute("email", user.getEmail());
						session.setAttribute("role", role);
						session.setAttribute("id", str_id);
						session.setAttribute("cross_id", user.getId());
						session.setAttribute("ITMDatabase", "itm3");
						session.setAttribute("token", itmToken);
						session.setAttribute("kftoken", token);
						session.setAttribute("kfURL",url);
						session.setAttribute("localdb", localdb.toLowerCase());
						session.setAttribute("community", community);
						session.setAttribute("community_id", community_id);
						String url1 = "project/openedit.jsp?community_id="+community_id+"&community="+community+"&localdb="+localdb.toLowerCase();
						response.sendRedirect(response.encodeURL(url1.replace(" ", "%20")));	
					
				}else{
					// if user already in the community
						// update the user info
					
					monitor.setMessage("Find user's  information at localdb, then update user info str_id="+str_id);
					MonitoringServices.sentMessage(monitor);
						if(
								role.trim().toLowerCase().equals("0")||
								role.trim().toLowerCase().equals("1")||
								role.trim().toLowerCase().equals("2")||
								role.trim().toLowerCase().equals("2"))
						{
							services.updateUserInfoInToCommunity(itmToken, localdb,  user.getUserName(), user.getLastName(), user.getFirstName(),   user.getEmail(),  str_id, role);
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
						
						

						if(role.trim().toLowerCase().equals("manager")){
							role="3";
						}
						if(role.trim().toLowerCase().equals("writer")){
							role="2";
						}
						if(role.trim().toLowerCase().equals("editor")){
							role="2";
						}
						if(role.trim().toLowerCase().equals("reader")){
							role="0";
						}
					
					session.setAttribute("super_token", "123456");
					session.setAttribute("email", user.getEmail());
					session.setAttribute("SessionTimeOut", request.getSession().getMaxInactiveInterval());
					session.setAttribute("role", role);
					session.setAttribute("username", user.getUserName());
					session.setAttribute("id", str_id);
					session.setAttribute("token", itmToken);
					session.setAttribute("kftoken", token);
					session.setAttribute("kfURL",url);
					session.setAttribute("localdb", localdb.toLowerCase());
					session.setAttribute("community", community);
					session.setAttribute("community_id", community_id);
					String url1 = "project/openedit.jsp?community_id="+community_id+"&community="+community+"&localdb="+localdb.toLowerCase();
					response.sendRedirect(response.encodeURL(url1.replace(" ", "%20")));	
				}
			}else{
				// if is a invalid user 
				response.sendRedirect(response.encodeURL("index.jsp?flag=fails"));	
					
			}
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
		
		
		
	}
	

	
	@SuppressWarnings("rawtypes")
	public User checkUser(String kfurl ,String token ,String community_id) throws ParseException{
		Client client = getClient();
		WebResource webResource = client.resource(kfurl+"api/authors/"+community_id+"/me");
	    ClientResponse response = webResource.header("Authorization","bearer "+token).get(ClientResponse.class);
	    String jsonStr = response.getEntity(String.class);
	    if(response.getStatus()!=200){
	    	return null;
	    }else{

	    	if(jsonStr.contains("userName")){
	    		JSONParser parser = new JSONParser();
	 		    Object obj = parser.parse(jsonStr);
	 	        JSONObject jsonObject = (JSONObject) obj;
	 	        User user = new User();
	 	        user.setAccess_token(token);
	 	        user.setEmail((String) jsonObject.get("email"));
	 	        user.setStr_id((String) jsonObject.get("_id"));
	 	        user.setFirstName((String) jsonObject.get("firstName"));
	 	        user.setLastName((String) jsonObject.get("lastName"));
	 	        user.setUserName((String) jsonObject.get("userName"));
	 	        user.setType((String) jsonObject.get("role"));
	 	       JSONObject communityJson= (JSONObject) jsonObject.get("_community");
	 	        user.setCommunity((String)communityJson.get("title") );
	 	        return user;
	    	}
	    	return null;
	    }
	}
	
	
	private Client getClient(){
		TrustManager[] trustAllCerts = new TrustManager[] {
			       new X509TrustManager() {
			          public java.security.cert.X509Certificate[] getAcceptedIssuers() {
			            return null;
			          }

			          public void checkClientTrusted(X509Certificate[] certs, String authType) {  }

			          public void checkServerTrusted(X509Certificate[] certs, String authType) {  }

			       }
			    };
		   HostnameVerifier hostnameVerifier = HttpsURLConnection.getDefaultHostnameVerifier();
		   DefaultClientConfig config = new DefaultClientConfig();
		   config.getFeatures().put(JSONConfiguration.FEATURE_POJO_MAPPING, Boolean.TRUE);
		   SSLContext ctx;
		try {
			ctx = SSLContext.getInstance("SSL");
			   ctx.init(null, trustAllCerts, null);
			   config.getProperties().put(HTTPSProperties.PROPERTY_HTTPS_PROPERTIES, new HTTPSProperties(hostnameVerifier, ctx));
		
		} catch (NoSuchAlgorithmException | KeyManagementException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		   Client client = Client.create(config);
		   return client;
	}
	
	public String getToken(int uid){
		String timeStamp = new SimpleDateFormat("yyyyMMddHHmmss").format(Calendar.getInstance().getTime());
		Random rand = new Random();
		int  n = rand.nextInt(1000) + 1;
		String token = timeStamp+String.valueOf(uid)+String.valueOf(n);
		return token;
		
	}
	

}
