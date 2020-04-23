<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Home</title>
	</head>
<body>
<br>
	
	<%
		String username = session.getAttribute("username") == null ? "" : session.getAttribute("username").toString();
		String password = session.getAttribute("password") == null ? "" : session.getAttribute("password").toString();
		String email = session.getAttribute("email") == null ? "" : session.getAttribute("email").toString();
		String first = session.getAttribute("first") == null ? "" : session.getAttribute("first").toString();
		String last = session.getAttribute("last") == null ? "" : session.getAttribute("last").toString();
		String phone = session.getAttribute("phone") == null ? "" : session.getAttribute("phone").toString();
		String city = session.getAttribute("city") == null ? "" : session.getAttribute("city").toString();
		String state = session.getAttribute("state") == null ? "" : session.getAttribute("state").toString();
		String zip = session.getAttribute("zip") == null ? "" : session.getAttribute("zip").toString();
		
	    out.println("Hey there,  " + "<b>" + username + "</b>!");
	    out.println("<br><br>");
	    
	    out.println("Your information:");
	    out.println("<table border=\"1\">");
	    
	    out.println("<tr>");
	    out.println("<td>Email</td>");
	    out.println("<td>First Name</td>");
	    out.println("<td>Last Name</td>");
	    out.println("<td>Phone</td>");
	    out.println("<td>City</td>");
	    out.println("<td>State</td>");
	    out.println("<td>Zip</td>");
	    out.println("</tr>");
	    
	    out.println("<tr>");
	    out.println("<td>"+email+"</td>");
	    out.println("<td>"+first+"</td>");
	    out.println("<td>"+last+"</td>");
	    out.println("<td>"+phone+"</td>");
	    out.println("<td>"+city+"</td>");
	    out.println("<td>"+state+"</td>");
	    out.println("<td>"+zip+"</td>");
	    out.println("</tr>");
	    
	    out.println("</table>");
	
	 %>
	 <br>
	 <br>
	
	<label>Search and View Functionality (Part II)</label>

	<form method="post" action="search.jsp">
		<input type="submit" value="search train schedules">
	</form>
	
	<form method="post" action="viewSchedule.jsp">
		<input type="submit" value="view train schedules">
	</form>
	
	<br>
	<br>
	
	<label>Reserve Functionality (Part III)</label>
	
	<form method="get" action="retrieveSchedules.jsp">
		<input type="submit" value="View Schedules">
	</form>	

	<form method = "get" action = "viewReservations.jsp">
		<input type="submit" value="View Your Reservations">
	</form>
	<br>
	<br>
	
	<label> Message Customer Service (Part IV)</label>
	
	<form method="get" action = "messageCustomerService.jsp">
		<input type="submit" value="Message Customer Service">
	</form>
	<br>
	<br>
	<a href="logout.jsp">Logout</a>
<br>

</body>
</html>
