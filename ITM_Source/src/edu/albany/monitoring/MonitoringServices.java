package edu.albany.monitoring;

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
import javax.ws.rs.core.MultivaluedMap;

import org.apache.commons.io.IOUtils;

import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;
import com.sun.jersey.api.client.config.DefaultClientConfig;
import com.sun.jersey.api.json.JSONConfiguration;
import com.sun.jersey.client.urlconnection.HTTPSProperties;
import com.sun.jersey.core.util.MultivaluedMapImpl;


public class MonitoringServices {

	
	public static  void sentMessage(MonitoringDao msg){
		Client client = getClient();
		WebResource webResource = client.resource("http://localhost:8080/IMonitoring/msg");
		  MultivaluedMap formData = new MultivaluedMapImpl();
		    formData.add("uid", msg.getUuid());
		    formData.add("cid", msg.getCid());
		    formData.add("time", msg.getTime());
		    formData.add("className", msg.getClassName());
		    formData.add("domain", msg.getDomain());
		    formData.add("function", msg.getFunctionName());
		    formData.add("message", msg.getMessage());
	    ClientResponse response = webResource.accept("application/json").type("application/x-www-form-urlencoded").post(ClientResponse.class, formData);
	    InputStream in =response.getEntityInputStream();
	    StringWriter writer = new StringWriter();
	    try {
			IOUtils.copy(in, writer, "utf-8");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	
	
	
	
	private static Client getClient(){
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
