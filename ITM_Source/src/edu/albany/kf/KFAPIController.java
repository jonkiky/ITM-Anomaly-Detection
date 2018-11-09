package edu.albany.kf;

import java.io.IOException;
import java.io.InputStream;
import java.io.StringWriter;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.X509Certificate;

import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.MultivaluedMap;

import org.apache.commons.io.IOUtils;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;
import com.sun.jersey.api.client.config.DefaultClientConfig;
import com.sun.jersey.api.json.JSONConfiguration;
import com.sun.jersey.client.urlconnection.HTTPSProperties;
import com.sun.jersey.core.util.MultivaluedMapImpl;


public class KFAPIController {

	
	public UserDao getUser(String kfurl ,String token ,String community_id) throws  org.json.simple.parser.ParseException{
		Client client = getClient();
		if(!kfurl.endsWith("/")){
			kfurl=kfurl+"/";
		}
		WebResource webResource = client.resource(kfurl+"api/authors/"+community_id+"/me");
	    ClientResponse response = webResource.header(HttpHeaders.AUTHORIZATION, "bearer "+token).type("application/x-www-form-urlencoded").get(ClientResponse.class); 
	    // System.out.println(response);
	    InputStream in =response.getEntityInputStream();
	    StringWriter writer = new StringWriter();
	    try {
			IOUtils.copy(in, writer, "utf-8");
		} catch (IOException e) {
			e.printStackTrace();
		}
	    String jsonStr = writer.toString();

	    if(response.getStatus()!=200){
	    	return null;
	    }else{
	    	if(jsonStr.contains("userName")){
	    		JSONParser parser = new JSONParser();
	 		    Object obj = parser.parse(jsonStr);
	 	        JSONObject jsonObject = (JSONObject) obj;
	 	       UserDao user = new UserDao();
	 	        user.setAccess_token(token);
	 	        user.setEmail((String) jsonObject.get("email"));
	 	        user.setStr_id((String) jsonObject.get("_id"));
	 	        user.setFirstName((String) jsonObject.get("firstName"));
	 	        user.setLastName((String) jsonObject.get("lastName"));
	 	        user.setUserName((String) jsonObject.get("userName"));
	 	        user.setType((String) jsonObject.get("role"));
	 	       JSONObject communityJson= (JSONObject) jsonObject.get("_community");
	 	        user.setCommunity(community_id);
	 	        user.setCommunity_name((String)communityJson.get("title") );
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
	
}
