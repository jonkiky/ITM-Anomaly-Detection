package edu.albany.services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import edu.albany.monitoring.MonitoringDao;
import edu.albany.monitoring.MonitoringServices;


public class InformationServices {

	sqls sql = new sqls();
	Connection conn = sql.getConn("itm3");
	

	MonitoringDao monitor = new MonitoringDao();
	
	public String getLocaldbByCommunityId(String community_id){
	
		
		
		String insertQuery = "select localdb  from itm3.connection_table where community_id='"
				+ community_id + "'";
		
		monitor.setClassName("InformationServices");
		monitor.setFunctionName("[SQL] getLocaldbByCommunityId");
		monitor.setTime(new Date().toString());
		monitor.setMessage(insertQuery);
		MonitoringServices.sentMessage(monitor);
		
		Statement stmt;
		try {
			stmt = conn.createStatement();
			System.out.print(insertQuery);
			ResultSet rs = stmt.executeQuery(insertQuery);
			while (rs.next()) {
				return (String) rs.getString("localdb");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return null;
	}
	
	public Community getLocalComunitiesByCommunityId(String id){
		Community c = new Community();
		String selectQuery="select * from itm3.connection_table where status ='active' and community_id='"+id+"' ";
		Statement stmt;
		monitor.setClassName("InformationServices");
		monitor.setFunctionName("[SQL] getLocalComunitiesByCommunityId");
		monitor.setTime(new Date().toString());
		monitor.setMessage(selectQuery);
		MonitoringServices.sentMessage(monitor);
		try {
			stmt = conn.createStatement();
			System.out.print(selectQuery);
			ResultSet row = stmt.executeQuery(selectQuery);
			while (row.next()) {
			c.setCommunity((String) row.getString("community_name"));
			c.setLocaldb((String) row.getString("localdb"));
			c.setCommunity_id((String) row.getString("community_id"));
			c.setCity((String) row.getString("city"));
			c.setSchool((String) row.getString("school_name"));
			c.setCountry((String) row.getString("country"));
			}} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		


		return c;
	}
	
	
	public List<User> getUserInfo(String email, String pwd) {
		List<User> info = new ArrayList<User>();
		String insertQuery = "select *  from itm3.user LEFT JOIN itm3.user_community on user_community.user_id=itm3.user.str_id where email='"
				+ email + "' and password='" + pwd + "'";
		Statement stmt;
		monitor.setClassName("InformationServices");
		monitor.setFunctionName("[SQL] getUserInfo(String email, String pwd)");
		monitor.setTime(new Date().toString());
		monitor.setMessage(insertQuery);
		MonitoringServices.sentMessage(monitor);
		try {
			stmt = conn.createStatement();
			System.out.print(insertQuery);
			ResultSet rs = stmt.executeQuery(insertQuery);
			while (rs.next()) {
				User user = new User();
				// localDB=rs.getString(0);
				user.setUserName(rs.getString("username"));
				user.setFirstName(rs.getString("first_name"));
				user.setLastName(rs.getString("last_name"));
				user.setToken(rs.getString("token"));
				user.setCommunity(rs.getString("community"));
				user.setLocalDatabases(rs.getString("localdb"));
				user.setGoogle_account(rs.getString("google_email"));
				user.setType(rs.getString("type"));
				user.setAccess_token(rs.getString("access_token"));
				info.add(user);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return info;
	}

	public List<User> getUserInfo(String token) {
		List<User> info = new ArrayList<User>();
		String insertQuery = "select *  from itm3.user LEFT JOIN itm3.user_community on user_community.user_id=itm3.user.str_id where token='"
				+ token + "'";
		Statement stmt;
		monitor.setClassName("InformationServices");
		monitor.setFunctionName("[SQL] getUserInfo(String token)");
		monitor.setTime(new Date().toString());
		monitor.setMessage(insertQuery);
		MonitoringServices.sentMessage(monitor);
		try {
			stmt = conn.createStatement();
			System.out.print(insertQuery);
			ResultSet rs = stmt.executeQuery(insertQuery);
			while (rs.next()) {
				User user = new User();
				// localDB=rs.getString(0);
				user.setUserName(rs.getString("username"));
				user.setFirstName(rs.getString("first_name"));
				user.setLastName(rs.getString("last_name"));
				user.setToken(rs.getString("token"));
				user.setCommunity(rs.getString("community"));
				user.setLocalDatabases(rs.getString("localdb"));
				user.setGoogle_account(rs.getString("google_email"));
				user.setType(rs.getString("type"));
				user.setAccess_token(rs.getString("access_token"));
				info.add(user);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return info;
	}

	public List<User> getUserInfoByKfid(String kf_id) {
		List<User> info = new ArrayList<User>();
		String insertQuery = "select *  from itm3.user where  str_id= '"
				+ kf_id + "'";
		monitor.setClassName("InformationServices");
		monitor.setFunctionName("[SQL] getUserInfoByKfid(String kf_id)");
		monitor.setTime(new Date().toString());
		monitor.setMessage(insertQuery);
		MonitoringServices.sentMessage(monitor);
		Statement stmt;
		try {
			stmt = conn.createStatement();
			System.out.print(insertQuery);
			ResultSet rs = stmt.executeQuery(insertQuery);
			while (rs.next()) {
				User user = new User();
				// localDB=rs.getString(0);
				user.setUserName(rs.getString("username"));
				user.setFirstName(rs.getString("first_name"));
				user.setLastName(rs.getString("last_name"));
				user.setToken(rs.getString("token"));
				user.setEmail(rs.getString("email"));
				info.add(user);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return info;
	}
	
	
	
	public List<User> getlocalUserInfoByAuthorId(String id, String db){
		List<User> info = new ArrayList<User>();
		String insertQuery = "select *  from " + db + ".user where str_id='" + id + "'";
		Statement stmt;
		monitor.setClassName("InformationServices");
		monitor.setFunctionName("[SQL] getlocalUserInfoByAuthorId(String id, String db)");
		monitor.setTime(new Date().toString());
		monitor.setMessage(insertQuery);
		MonitoringServices.sentMessage(monitor);
		try {
			stmt = conn.createStatement();
			System.out.print(insertQuery);
			ResultSet rs = stmt.executeQuery(insertQuery);
			while (rs.next()) {
				User user = new User();
				user.setFirstName(rs.getString("username"));
				user.setLastName(rs.getString("last_name"));
				user.setType(rs.getString("role"));
				user.setStr_id(rs.getString("str_id"));
				user.setEmail(rs.getString("email"));
				user.setToken(rs.getString("token"));
				info.add(user);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return info;
	}
	
	public String getProjectNameById(String id, String db){
		String returnValue="";
		String insertQuery = "select *  from " + db + ".project where id=" + id ;
		Statement stmt;
		monitor.setClassName("InformationServices");
		monitor.setFunctionName("[SQL] getProjectNameById(String id, String db)");
		monitor.setTime(new Date().toString());
		monitor.setMessage(insertQuery);
		MonitoringServices.sentMessage(monitor);
		try {
			stmt = conn.createStatement();
			System.out.print(insertQuery);
			ResultSet rs = stmt.executeQuery(insertQuery);
			while (rs.next()) {
				returnValue=rs.getString("title");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return returnValue;
	}

	
	public String getSuperTalkNameById(String id){
		String returnValue="";
		String insertQuery = "select *  from itm3.super_talk where id=" + id ;
		Statement stmt;
		monitor.setClassName("InformationServices");
		monitor.setFunctionName("[SQL] getSuperTalkNameById(String id)");
		monitor.setTime(new Date().toString());
		monitor.setMessage(insertQuery);
		MonitoringServices.sentMessage(monitor);
		try {
			stmt = conn.createStatement();
			System.out.print(insertQuery);
			ResultSet rs = stmt.executeQuery(insertQuery);
			while (rs.next()) {
				returnValue=rs.getString("title");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return returnValue;
	}

	public List<User> getlocalUserInfo(String token, String db) {
		List<User> info = new ArrayList<User>();
		String insertQuery = "select *  from " + db + ".user where token='" + token + "'";
		Statement stmt;
		monitor.setClassName("InformationServices");
		monitor.setFunctionName("[SQL] getlocalUserInfo(String token, String db)");
		monitor.setTime(new Date().toString());
		monitor.setMessage(insertQuery);
		MonitoringServices.sentMessage(monitor);
		try {
			stmt = conn.createStatement();
			System.out.print(insertQuery);
			ResultSet rs = stmt.executeQuery(insertQuery);
			while (rs.next()) {
				User user = new User();
				user.setFirstName(rs.getString("username"));
				user.setLastName(rs.getString("last_name"));
				user.setType(rs.getString("role"));
				user.setStr_id(rs.getString("str_id"));
				user.setEmail(rs.getString("email"));
				info.add(user);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return info;
	}

	public String addUserInfoInToCommunity(
			String token,
			String db,
			String username,
			String lastName,
			String firstName,
			String email,
			String kf_id,
			String role,
			String community
			){
	       Statement stmt;
			try {
				PreparedStatement ps = null;
				String insertQuery="Insert Ignore into "+db+".user (first_name,last_name,username,type,email,str_id,community,token) values(\""
			   	    		 +firstName+"\",\""
			   	    		 +lastName+"\",\""
			   	    		 +username+"\",\""
			   	    		 +role+"\",\""
			   	    		 +email+"\",\""
			   	    		 +kf_id+"\",\""
			   	    		 +kf_id+"\",\""
			   	    		 +token+"\");"
			   	    		 ;
			    	
	    	    System.out.println("save User info into local database by query :" + insertQuery);
	    	     
	    	    monitor.setClassName("InformationServices");
	    		monitor.setFunctionName("[SQL] addUserInfoInToCommunity");
	    		monitor.setTime(new Date().toString());
	    		monitor.setMessage(insertQuery);
	    		MonitoringServices.sentMessage(monitor);
	    		
	   	     // Create blob here
	            stmt = conn.createStatement();
	   			stmt.executeUpdate(insertQuery);
				 return kf_id;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return "-1";
		}

	public String updateUserInfoInToCommunity(
			String token,
			String db,
			String username,
			String lastName,
			String firstName,
			String email,
			String kf_id,
			String role
			){
	       Statement stmt;
			try {
				PreparedStatement ps = null;
				String updateQuery="update "+db+".user "
						+ "set first_name = \""+firstName
						+"\",last_name=\""+lastName
						+"\",username=\""+username
						+"\",type=\""+role
						+"\",email= \""+email
						+"\",token=\""+token+"\""
						+" where str_id=\""+kf_id+"\""		
			   	    		 ;
			    monitor.setClassName("InformationServices");
	    		monitor.setFunctionName("[SQL] updateUserInfoInToCommunity");
	    		monitor.setTime(new Date().toString());
	    		monitor.setMessage(updateQuery);
	    		MonitoringServices.sentMessage(monitor);
	    	    
	   	     // Create blob here
	            stmt = conn.createStatement();
	   			stmt.executeUpdate(updateQuery);
				 return kf_id;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return "-1";
		}
	
	
	public String addUserInfoIntoITM(
			String token,
			String db,
			String username,
			String lastName,
			String firstName,
			String email,
			String kf_id,
			String role,
			String community_id){
		
			SimpleDateFormat ft =  new SimpleDateFormat ("E yyyy.MM.dd 'at' hh:mm:ss a zzz");
	       String date = ft.format(new Date());
	       Statement stmt;
			try {
				PreparedStatement ps = null;
				String insertQuery="Insert Ignore into "+db+".user (first_name,last_name,username,email,str_id,type,token) values(\""
			   	    		 +firstName+"\",\""
			   	    		 +lastName+"\",\""
			   	    		 +username+"\",\""
			   	    		 +email+"\",\""
			   	    		 +kf_id+"\",\""
			   	    		 +role+"\",\""
			   	    		 +token+"\");"
			   	    		 ;
			    	
	    	    System.out.println("save User info into local database by query :" + insertQuery);
	    	    monitor.setClassName("InformationServices");
	    		monitor.setFunctionName("[SQL] addUserInfoIntoITM");
	    		monitor.setTime(new Date().toString());
	    		monitor.setMessage(insertQuery);
	    		MonitoringServices.sentMessage(monitor);
	   	     // Create blob here
	            stmt = conn.createStatement();
	   			stmt.executeUpdate(insertQuery);
				 return kf_id;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return "-1";
		}

	
	

	public String addUserCommunityInfoIntoITM(
			String token,
			String db,
			String username,
			String lastName,
			String firstName,
			String email,
			String kf_id,
			String role,
			String community,
			String localdb,
			String community_id){
		
			SimpleDateFormat ft =  new SimpleDateFormat ("E yyyy.MM.dd 'at' hh:mm:ss a zzz");
	        String date = ft.format(new Date());
	        Statement stmt;
			
			
			try {
				PreparedStatement ps = null;
				String insertQuery="Insert Ignore into "+db+".user_community (user_id,community,type,localdb,token,username,community_id,last_login_time) values(\""
			   	    		 +kf_id+"\",\""
			   	    		 +community+"\",\""
			   	    		 +role+"\",\""
			   	    		 +localdb+"\",\""
			   	    		 +token+"\",\""
			   	    		 +username+"\",\""
			   	    		 +community_id+"\",\""
			   	    		 +date+"\");"
			   	    		 ;
		   	    monitor.setClassName("InformationServices");
			    		monitor.setFunctionName("[SQL] addUserCommunityInfoIntoITM");
			    		monitor.setTime(new Date().toString());
			    		monitor.setMessage(insertQuery);
			    		MonitoringServices.sentMessage(monitor);
	    	    System.out.println("save User info into local database by query :" + insertQuery);
	    	     
	   	     // Create blob here
	            stmt = conn.createStatement();
	   			stmt.executeUpdate(insertQuery);
				 return kf_id;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			return "-1";
		}

	
	


	public List<User> getUserCommunityInfo(String str_id, String community_id) {
		List<User> info = new ArrayList<User>();
		String insertQuery = "select *  from itm3.user_community where  user_id= '"+ str_id + "' and community_id='"+community_id+"'";
		Statement stmt;
   	    monitor.setClassName("InformationServices");
		monitor.setFunctionName("[SQL] getUserCommunityInfo");
		monitor.setTime(new Date().toString());
		monitor.setMessage(insertQuery);
		MonitoringServices.sentMessage(monitor);
		try {
			stmt = conn.createStatement();
			System.out.print(insertQuery);
			ResultSet rs = stmt.executeQuery(insertQuery);
			while (rs.next()) {
				User user = new User();
				// localDB=rs.getString(0);
				user.setToken(rs.getString("token"));
				info.add(user);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return info;
	}
	
	public List<User> getCrossUserInfo(String email, String pwd) {
		List<User> info = new ArrayList<User>();
		String insertQuery = "select *  from itm3.user LEFT JOIN itm3.user_community on user_community.user_id=itm3.user.str_id where email='"
				+ email + "' and password='" + pwd + "'";
		Statement stmt;
		try {
			stmt = conn.createStatement();
			System.out.print(insertQuery);
			ResultSet rs = stmt.executeQuery(insertQuery);
			 monitor.setClassName("InformationServices");
				monitor.setFunctionName("[SQL] getCrossUserInfo");
				monitor.setTime(new Date().toString());
				monitor.setMessage(insertQuery);
				MonitoringServices.sentMessage(monitor);
			while (rs.next()) {
				User user = new User();
				// localDB=rs.getString(0);
				user.setUserName(rs.getString("username"));
				user.setFirstName(rs.getString("first_name"));
				user.setLastName(rs.getString("last_name"));
				user.setToken(rs.getString("token"));
				user.setCommunity(rs.getString("community"));
				user.setLocalDatabases(rs.getString("localdb"));
				user.setGoogle_account(rs.getString("google_email"));
				user.setType(rs.getString("type"));
				user.setAccess_token(rs.getString("access_token"));
				info.add(user);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return info;
	}

}
