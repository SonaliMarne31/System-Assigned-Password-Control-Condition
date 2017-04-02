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
	String password = request.getParameter("userpwd");
	PreparedStatement pst = connection.prepareStatement("Select * from user where userID=?");
	pst.setString(1, name);
	ResultSet rs = pst.executeQuery();
	String pass = "";
	Date start = (Date)session.getAttribute("loginStartTime");
	Date end = new Date();
	//getTime() returns current time in milliseconds
	long time = end.getTime();
	//Passed the milliseconds to constructor of Timestamp class 
	Timestamp ts = new Timestamp(time);
	long difference = end.getTime() - start.getTime();
	long seconds = TimeUnit.MILLISECONDS.toSeconds(difference);
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String currentTime = sdf.format(end);
	if(rs.next()){
		 pass = rs.getString("password");
		 if(pass.equals(password)){
				Statement stmt1 = connection.createStatement();
				String command = "INSERT INTO login(userID,login_date,login_time,success) VALUES ('"+name+"','"+currentTime+"','"+seconds+"','S')";
				stmt1.executeUpdate(command);
				session.invalidate();
		 }else {
			 	Statement stmt1 = connection.createStatement();
				String command = "INSERT INTO login(userID,login_date,login_time,success) VALUES ('"+name+"','"+currentTime+"','"+seconds+"','F')";
				stmt1.executeUpdate(command);
				response.sendRedirect("loginHome.jsp");
				session.setAttribute("incorrect", "1");
		 }
	 
	}
%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="css/style.css" media="screen" type="text/css" />
<title>System-Generated Password</title>
</head>
<body>
	<div class="title">System-Generated Password</div>
	<div class="normal_title">Login Successful <%=name %></div>
	<div class="normal_title"><br><a href="loginHome.jsp">Login Again</a></div>
</body>
</html>