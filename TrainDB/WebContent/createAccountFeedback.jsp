<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.traindb.pk.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Train Login</title>
</head>
<body>
	<%
	    
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Get the username and password from html text boxes
			String username = request.getParameter("username").equals("") ? null : request.getParameter("username");
			String password1 = request.getParameter("password1").equals("") ? null : request.getParameter("password1");
			String password2 = request.getParameter("password2").equals("") ? null : request.getParameter("password2");
			String email = request.getParameter("email").equals("") ? null : request.getParameter("email");
			String first = request.getParameter("first").equals("") ? null : request.getParameter("first");
			String last = request.getParameter("last").equals("") ? null : request.getParameter("last");
			String phone = request.getParameter("phone").equals("") ? null : request.getParameter("phone");
			String city = request.getParameter("city").equals("") ? null : request.getParameter("city");
			String state = request.getParameter("state").equals("") ? null : request.getParameter("state");
			String zip = request.getParameter("zip").equals("") ? null : request.getParameter("zip");
			
			//out.print(username +  password1 + email +  first +  last+ phone+city+ state+ zip);
			if (username == null) {
				out.print("You must enter a valid username");
			} else if (password1 == null) {
				out.print("You must enter a valid password");
			} else if (!password1.equals(password2)) {
				out.print("Your password do not match, please try again.");
			} else {
				//no error, create the account
				PreparedStatement pmst = con.prepareStatement("INSERT INTO customers(username, password, email, first, last, phone, city, state, zip) VALUES (?,?,?,?,?,?,?,?,?)");
				try {
					pmst.setString(1, username);
					pmst.setString(2, password1);
					pmst.setString(3, email);
					pmst.setString(4, first);
					pmst.setString(5, last);
					pmst.setString(6, phone);
					pmst.setString(7, city);
					pmst.setString(8, state);
					pmst.setString(9, zip);
					pmst.execute();
					
					out.print("Successfully created account!");
				} catch (Exception e) {
					out.print("An account with that username already exists");
				}
			}
					  	
			//close the connection.
			db.closeConnection(con);
		} catch (Exception e) {
			out.print(e);
		}
	%>
	
	<form method="post" action="index.jsp">
	<input type="submit" value="Home">
	</form>
</body>
</html>