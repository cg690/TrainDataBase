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
			String password = request.getParameter("password");
			
			PreparedStatement st = con.prepareStatement("SELECT * FROM customers WHERE username = ?");
			st.setString(1, username);
			ResultSet rs = st.executeQuery();

			if (rs.next()) {
				if (rs.getString("password").equals(password)) {
					out.print("You successfully logged in!");
				} else {
					out.print("You entered the wrong password");
				}
			} else {
				//no result set from username means the user doesn't exist
				out.print("There is no account associated with that username");
			}


			//close the connection.
			db.closeConnection(con);
		} catch (Exception e) {
			out.print(e);
		}
	%>
</body>
</html>