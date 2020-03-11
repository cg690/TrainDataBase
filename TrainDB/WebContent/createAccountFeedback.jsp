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
			String username = request.getParameter("username");
			String password1 = request.getParameter("password1");
			String password2 = request.getParameter("password2");
			
			if (username.equals("")) {
				out.print("You must enter a valid username");
			} else if (password1.equals("")) {
				out.print("You must enter a valid password");
			} else if (!password1.equals(password2)) {
				out.print("Your password do not match, please try again.");
			} else {
				//no error, create the account
				Statement st=con.createStatement();
				try {
					st.executeUpdate("INSERT INTO customers(username, password) VALUES ('"+username+"','"+password1+"')");
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