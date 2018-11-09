package edu.albany.services;


import java.sql.*;

import com.mysql.jdbc.exceptions.MySQLSyntaxErrorException;

public class sqls {
    private Connection con = null;
    public Statement Connect(String strdb) {
        String url = "jdbc:mysql://localhost:3306/";
        String db = strdb;
        String driver = "com.mysql.jdbc.Driver";
        String user = "root";
        String pass = "123456";
        //String  pass="DtZBAxrN57Mx";
        //String  pass="HD4NXr6E9E8G28P";
        try { 
            Class.forName(driver);
            this.con = DriverManager.getConnection(url + db, user, pass);
            Statement stmt = con.createStatement();
          Parameter.connnum = Parameter.connnum + 1;
            return stmt;
        } catch (Exception e) {
            System.out.println(e);
            e.printStackTrace();
        }
        return null;
      
    }
        
    public void Close() {
        try {
            if(this.con != null) {
                this.con.close();
                Parameter.connnum = Parameter.connnum - 1;
                System.out.println("in the Close function of sqls and the connum is " + Parameter.connnum);
            }
        } catch(SQLException e) {
            e.printStackTrace();
        }

    }

    /**
    * For preparedstatement use
    * @param strdb
    * @return connection
    */
    public Connection getConn(String strdb) {
        //Connection con = null;
        String url = "jdbc:mysql://localhost:3306/";
        String db = strdb;
        String driver = "com.mysql.jdbc.Driver";
        String user = "root";
        String pass = "123456";        
        //String  pass="DtZBAxrN57Mx";
        //String  pass="HD4NXr6E9E8G28P";
        try {
            Class.forName(driver);
            this.con = DriverManager.getConnection(url + db, user, pass);
            return con;
        } catch (Exception e) {
            System.out.println(e);
            e.printStackTrace();
        }
        return null;
    }
    
    
    public static void main(String[] args){
    	System.out.print("it is sqls file");
    }
}
