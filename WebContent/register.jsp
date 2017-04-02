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
<%@page import="java.util.logging.Logger" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String connectionURL = "jdbc:mysql://localhost:3306/controlcondition";
	Connection connection = null; 
	Class.forName("com.mysql.jdbc.Driver").newInstance(); 
	connection = DriverManager.getConnection(connectionURL, "root", "root");
	String name = request.getParameter( "username" );
	
	PreparedStatement pst = connection.prepareStatement("Select * from allowed_users where userID=?");
	pst.setString(1, name);
	ResultSet rs = pst.executeQuery();   

	String pw = "";
    String pw2 = "";	
	
	if(rs.next()){
		//check is user is already registered
		int id = rs.getInt("isReg");
		if(id == 1){
			session.setAttribute("isRegistered", "1");
			response.sendRedirect("index.jsp");
		}else {
				// Timer start for registration time.
				Date date= new Date();
				//getTime() returns current time in milliseconds
				long time = date.getTime();
				//Passed the milliseconds to constructor of Timestamp class 
				Timestamp ts = new Timestamp(time);
				session.setAttribute( "regStartTime", date );
				session.setAttribute( "username", name );
				
				
				Random RANDOM = new SecureRandom();
			  /** Length of password. @see #generateRandomPassword() */
			  	int PASSWORD_LENGTH = 4;
			  /**
			   * Generate a random String suitable for use as a temporary password.
			   *
			   * @return String suitable for use as a temporary password
			   * @since 2.4
			   */
			 
		      // Pick from some letters that won't be easily mistaken for each
		      // other. So, for example, omit o O and 0, 1 l and L.
		      String letters = "abcdefghijklmnopqrstuvwxyz";

		        
		      for (int i=0; i<PASSWORD_LENGTH; i++)
		      {
		          int index = (int)(RANDOM.nextDouble()*letters.length());
		          pw += letters.substring(index, index+1);
		      }
		       pw2=pw;
       
		       String random = pw2;
		       session.setAttribute( "randompwd", random);
		}
	}else {
		session.setAttribute("isRegistered", "1");
		response.sendRedirect("index.jsp");
	}
%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="css/style.css" media="screen" type="text/css" />
<title>Insert title here</title>
</head>
<script>
        

        window.location.hash="no-back-button";
        window.location.hash="Again-No-back-button";//again because google chrome don't insert first hash into history
        window.onhashchange=function(){window.location.hash="no-back-button";}
  
        
        function checkPass1()
        {
            //Store the password field objects into variables ...
            var pass1 = document.getElementById('pass1');
            var pass2 = '<%=pw2%>';
            
            //Store the Confimation Message Object ...
            var message = document.getElementById('confirmMessage1');
            //Set the colors we will be using ...
            var goodColor = "#66cc66";
            var badColor = "#ff6666";
            //Compare the values in the password field 
            //and the confirmation field
            if(pass1.value == pass2){
            	//alert(pass2);
                //The passwords match. 
                //Set the color to the good color and inform
                //the user that they have entered the correct password 
                pass1.style.backgroundColor = goodColor;
                message.style.color = goodColor;
                message.innerHTML = "Passwords Match!"
            }else{
                //The passwords do not match.
                //Set the color to the bad color and
                //notify the user.
                pass1.style.backgroundColor = badColor;
                message.style.color = badColor;
                message.innerHTML = "Passwords Do Not Match!"
                document.getElementById('Register').disabled = true;
            }
        }  
        
        
        
        function checkPass2()
        {
            //Store the password field objects into variables ...
            var pass1 = document.getElementById('pass1');
            var pass2 = document.getElementById('pass2');
            var pass3 = '<%=pw2%>';
            //alert(pass3)
            //Store the Confimation Message Object ...
            var message = document.getElementById('confirmMessage2');
            //Set the colors we will be using ...
            var goodColor = "#66cc66";
            var badColor = "#ff6666";
            //Compare the values in the password field 
            //and the confirmation field
            if(pass1.value == pass2.value){
                //The passwords match. 
                //Set the color to the good color and inform
                //the user that they have entered the correct password 
                pass2.style.backgroundColor = goodColor;
                message.style.color = goodColor;
                message.innerHTML = "Passwords Match!"
                if(pass2.value == pass3){
                    //alert(pass3);
                    document.getElementById('Register').disabled = false;
                }
                
            }else{
                //The passwords do not match.
                //Set the color to the bad color and
                //notify the user.
                pass2.style.backgroundColor = badColor;
                message.style.color = badColor;
                document.getElementById('Register').disabled = true;
                message.innerHTML = "Passwords Do Not Match!"
            }
        }  
      
</script>
<body>
	<div class="title">System-Generated Password</div>
	<form class="loginbox" action="success.jsp" method="post" id="register_sub">	
		<div class="sec_password"> Your password is <b><%= pw %></b></div>
		<input type="text" id="pass1" required placeholder="Enter above password" autocomplete="off" onkeyup="checkPass1(); return false;"> 
		<span id="confirmMessage1" class="confirmMessage"></span>
		<div class="line_separator">
			<i></i>
		</div>
		<input type="text" id="pass2" required placeholder="Confirm Password" autocomplete="off" onkeyup="checkPass2(); return false;"> 
		<div class="line_separator">
			<i></i>
		</div>
		<span id="confirmMessage2" class="confirmMessage"></span>
		<input type="submit" id="Register" disabled="true">
	</form>
</body>
</html>