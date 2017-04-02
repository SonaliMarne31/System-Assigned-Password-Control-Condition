<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%
	if(session.getAttribute("isRegistered") == null){
		
		session.setAttribute("isRegistered", "0");
	}
	String isRegistered = (String)session.getAttribute( "isRegistered" );
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" href="css/style.css" media="screen" type="text/css" />
	<title>Control Condition</title>
</head>
<body>
	<div class="title">System-Generated Password</div>
	<form class="loginbox" action="register.jsp" method="post" id="login_form">	
		<%
                if(isRegistered == "1"){
                    out.print("<p align=\"center\" style=\"color:red\">Invalid username/ Already registered</p>");
                	session.setAttribute("isRegistered", "0");
                }
		%>
		<div class="wrap_form"><label class='label_for' for="username">Username</label>	
		<input type="text" name="username" required placeholder="Only for new user" autocomplete="off"></div> 
		<div class="line_separator">
			<i></i>
		</div>
		<input type="submit" name="Submit" value="Submit"></input>
		<div id="lower">
			<br><a href="loginHome.jsp">Existing User- Login </a>
		</div><!--/ lower-->
	</form>
</body>
</html>