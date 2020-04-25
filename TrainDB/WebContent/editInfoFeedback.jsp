<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.traindb.pk.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit customer info</title>
</head>
<body>
	<%
	    
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Get the username and password from html text boxes
			String email = request.getParameter("email").equals("") ? null : request.getParameter("email");
			String first = request.getParameter("first").equals("") ? null : request.getParameter("first");
			String last = request.getParameter("last").equals("") ? null : request.getParameter("last");
			String phone = request.getParameter("phone").equals("") ? null : request.getParameter("phone");
			String city = request.getParameter("city").equals("") ? null : request.getParameter("city");
			String state = request.getParameter("state").equals("") ? null : request.getParameter("state");
			String zip = request.getParameter("zip").equals("") ? null : request.getParameter("zip");
			
			session.setAttribute("email", email);
			session.setAttribute("first", first);
			session.setAttribute("last", last);
			session.setAttribute("phone", phone);
			session.setAttribute("city", city);
			session.setAttribute("state", state);
			session.setAttribute("zip", zip);
			
			//out.print(username +  password1 + email +  first +  last+ phone+city+ state+ zip)
				//no error, create the account
				PreparedStatement pmst = con.prepareStatement("UPDATE customers SET email=?, first=?, last=?, phone=?, city=?, state=?, zip=? WHERE username='"+session.getAttribute("username")+"'");
				try {
					pmst.setString(1, email);
					pmst.setString(2, first);
					pmst.setString(3, last);
					pmst.setString(4, phone);
					pmst.setString(5, city);
					pmst.setString(6, state);
					pmst.setString(7, zip);
					pmst.execute();
					
					out.print("Successfully Edited");
				} catch (Exception e) {
					out.print("Couldn't edit");
				}
					  	
			//close the connection.
			db.closeConnection(con);
		} catch (Exception e) {
			out.print(e);
		}
	%>
	
	<form method="post" action="adminUI.jsp">
	<input type="submit" value="Admin Home">
	</form>
</body>
</html>