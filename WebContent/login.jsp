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
	String name = request.getParameter( "username" );
	
	//Check if already registered	
	PreparedStatement pst = connection.prepareStatement("Select * from user where userID=?");
	pst.setString(1, name);
	ResultSet rs = pst.executeQuery();   
	session.setAttribute("notReg","0");
	if(rs.next()){
		//Ask user to enter password.
		// Timer start for login time.
		Date date= new Date();
		//getTime() returns current time in milliseconds
		long time = date.getTime();
		//Passed the milliseconds to constructor of Timestamp class 
		Timestamp ts = new Timestamp(time);
		session.setAttribute( "loginStartTime", date );
		session.setAttribute( "username", name );		
		
	}else {
		session.setAttribute("notReg","1");
		response.sendRedirect("loginHome.jsp");
	}
	
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>System-Assigned Password Login</title>
<link rel="stylesheet" href="css/style.css" media="screen" type="text/css" />
</head>
<body>
	<div class="title">System-Generated Password Login</div>
	<form class="loginbox" action="loginDone.jsp" method="post" id="login_form">	
		<%-- <%
                if(incorrect == "1"){
                    out.print("<p align=\"center\" style=\"color:red\">Invalid password. Please re-enter</p>");
                	session.setAttribute("incorrect", "0");
                }
		%> --%>
		<div class="wrap_form"><label class='label_for' for="userpwd">Password</label>	
		<input type="text" name="userpwd" required placeholder="Enter your password" autocomplete="off"></div> 
		<div class="line_separator">
			<i></i>
		</div>
		<input type="submit" name="Submit" value="Login"></input>
		
	</form>
</body>
</html>