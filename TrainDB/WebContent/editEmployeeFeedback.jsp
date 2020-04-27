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
			
			String first = request.getParameter("first").equals("") ? null : request.getParameter("first");
			String last = request.getParameter("last").equals("") ? null : request.getParameter("last");
			
			session.setAttribute("first", first);
			session.setAttribute("last", last);
			
			//out.print(username +  password1 + email +  first +  last+ phone+city+ state+ zip)
				//no error, create the account
			if(session.getAttribute("op").equals("edit")){
				PreparedStatement pmst = con.prepareStatement("UPDATE employee SET first=?, last=? WHERE ssn='"+session.getAttribute("ssn")+"'");
				try {
					pmst.setString(1, first);
					pmst.setString(2, last);
					pmst.execute();
					
					out.print("Successfully Edited");
				} catch (Exception e) {
					out.print("Couldn't edit");
				}
			}
			else if(session.getAttribute("op").equals("add")){
				PreparedStatement pmst = con.prepareStatement("INSERT INTO employee(ssn, first, last) VALUES (?,?,?)");
				try{
					pmst.setString(1, session.getAttribute("ssn").toString());
					pmst.setString(2, first);
					pmst.setString(3, last);
					pmst.execute();
					
					out.print("Successfully added");
				} catch (Exception e) {
					out.print("Couldn't add");
				}
			}
					  	
			//close the connection.
			db.closeConnection(con);
		} catch (Exception e) {
			out.print("Yikes there was an error!");
			out.print(e);
		}
	%>
	
	<form method="post" action="adminUI.jsp">
	<input type="submit" value="Admin home">
	</form>
</body>
</html>