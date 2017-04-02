<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 
<%@ page import ="java.sql.CallableStatement" %>
<%@ page import ="java.io.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.util.Random"%>
<%@ page import="java.util.concurrent.TimeUnit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String connectionURL = "jdbc:mysql://localhost:3306/controlcondition";
	Connection connection = null; 
	Class.forName("com.mysql.jdbc.Driver").newInstance(); 
	connection = DriverManager.getConnection(connectionURL, "root", "root");
	String name = (String)session.getAttribute( "username" );
	//session.setAttribute( "username", name );
	String password = (String)session.getAttribute( "randompwd");
	
	
	Date start = (Date)session.getAttribute("regStartTime");
	Date end = new Date();
	//getTime() returns current time in milliseconds
	long time = end.getTime();
	//Passed the milliseconds to constructor of Timestamp class 
	Timestamp ts = new Timestamp(time);
	long difference = end.getTime() - start.getTime();
	long seconds = TimeUnit.MILLISECONDS.toSeconds(difference);
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String currentTime = sdf.format(end);
	
	Statement stmt1 = connection.createStatement();
	String command = "INSERT INTO user(userID,password,reg_time,reg_date) VALUES ('"+name+"','"+password+"','"+seconds+"','"+currentTime+"')";
	stmt1.executeUpdate(command);
	
	int isReg = 1;
	PreparedStatement pst = connection.prepareStatement("update allowed_users set isReg=? where userID=?");
	pst.setInt(1, isReg);
	pst.setString(2, name);
	
	pst.executeUpdate(); 
	
	session.invalidate();
	
%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="css/style.css" media="screen" type="text/css" />
<title>System-Generated Password</title>
</head>
<body>
	<div class="title">System-Generated Password</div>
	<div class="normal_title">Registration Successful</div>
	<div class="normal_title"><br><a href="loginHome.jsp">Login Now</a></div>
</body>
</html>