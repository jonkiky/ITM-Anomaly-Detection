package edu.albany.kf;

import java.io.Serializable;


public class UserDao implements Serializable {

	private static final long serialVersionUID = 1L;
	private int id;
	private String userName;
	private String firstName;
	private String lastName;
	private String type;
	private String password;
	private String email;
	private String Community;
	private String localDatabases;
	private String token;
	private String kf5_id;
	private String google_account;
	private String gender;
	private String age;
	private String profile_image;
	private String content;
	private String str_id;
	private String access_token;
	private String community_name;
	
	
	

	public String getCommunity_name() {
		return community_name;
	}
	public void setCommunity_name(String community_name) {
		this.community_name = community_name;
	}
	public String getAccess_token() {
		return access_token;
	}
	public void setAccess_token(String access_token) {
		this.access_token = access_token;
	}
	public String getCommunity() {
		return Community;
	}
	public void setCommunity(String community) {
		Community = community;
	}
	public String getGoogle_account() {
		return google_account;
	}
	public void setGoogle_account(String google_account) {
		this.google_account = google_account;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}
	public String getProfile_image() {
		return profile_image;
	}
	public void setProfile_image(String profile_image) {
		this.profile_image = profile_image;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getStr_id() {
		return str_id;
	}
	public void setStr_id(String str_id) {
		this.str_id = str_id;
	}
	public String getKf5_id() {
		return kf5_id;
	}
	public void setKf5_id(String kf5_id) {
		this.kf5_id = kf5_id;
	}
	public String getToken() {
		return token;
	}
	public void setToken(String token) {
		this.token = token;
	}


	public String getLocalDatabases() {
		return localDatabases;
	}
	public void setLocalDatabases(String localDatabases) {
		this.localDatabases = localDatabases;
	}

	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public UserDao() {
	}

}