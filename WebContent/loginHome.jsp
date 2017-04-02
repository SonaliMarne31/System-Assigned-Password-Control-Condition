<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% 
	if(session.getAttribute("notReg") == null){
		
		session.setAttribute("notReg", "0");
	}
	String notRegistered = (String)session.getAttribute( "notReg" );
	if(session.getAttribute("incorrect") == null){
		
		session.setAttribute("incorrect", "0");
	}
	String incorrect = (String)session.getAttribute( "incorrect" );
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>System-Assigned Password Login</title>
<link rel="stylesheet" href="css/style.css" media="screen" type="text/css" />
</head>
<body>
	<div class="title">System-Generated Password Login</div>
	<form class="loginbox" action="login.jsp" method="post" id="login_form">	
		<%
                if(notRegistered == "1"){
                    out.print("<p align=\"center\" style=\"color:red\">User not registered. Please <a href=\"index.jsp\">Register Here</a></p>");
                	session.setAttribute("notReg", "0");
                }
				 if(incorrect == "1"){
		             out.print("<p align=\"center\" style=\"color:red\">Password Incorrect</a></p>");
		         	session.setAttribute("incorrect", "0");
		         }
		%>
		<div class="wrap_form"><label class='label_for' for="username">Username</label>	
		<input type="text" name="username" required placeholder="Existing users" autocomplete="off"></div> 
		<div class="line_separator">
			<i></i>
		</div>
		<input type="submit" name="Submit" value="Enter"></input>
		
	</form>
</body>
</html>