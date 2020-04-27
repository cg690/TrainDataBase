<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.traindb.pk.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%
Connection con = null;
PreparedStatement statement = null;
ResultSet resultSet = null;
%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Employee Home</title>
	</head>
<body>
<br>
	
	<%
		String username = session.getAttribute("username") == null ? "" : session.getAttribute("username").toString();
		String password = session.getAttribute("password") == null ? "" : session.getAttribute("password").toString();
		String ssn = session.getAttribute("ssn") == null ? "" : session.getAttribute("ssn").toString();
		String first = session.getAttribute("first") == null ? "" : session.getAttribute("first").toString();
		String last = session.getAttribute("last") == null ? "" : session.getAttribute("last").toString();
		
	    out.println("<p>Hi there," + first + "!</p>");
	    out.println("<br><br>");
	    
	    out.println("Your information:");
	    out.println("<table border=\"1\">");
	    
	    out.println("<tr>");
	    out.println("<td>SSN (Just for Demo)</td>");
	    out.println("<td>First Name</td>");
	    out.println("<td>Last Name</td>");
	    out.println("</tr>");
	    
	    out.println("<tr>");
	    out.println("<td>"+ssn+"</td>");
	    out.println("<td>"+first+"</td>");
	    out.println("<td>"+last+"</td>");
	    out.println("</tr>");
	    
	    out.println("</table>");
	
	 %>
	 <br>
	 <h2>Reservations assigned to you</h2>
	 <table border = "1">
				<tr>
				<td>Reservation ID</td>
				<td>Username</td>
				<td>Transit Name</td>
				<td>Schedule ID</td>
				<td>Train ID</td>
				<td>Origin Station ID</td>
				<td>Destination Station ID</td>
				<td>Booking Fee</td>
				<td>Total Fare</td>
				<td>Booking Date</td>
				<td>Past Reservation</td>
				<td>Seat Number</td>
				<td>Class</td>
				</tr>
	 <%
		try{
		ApplicationDB db = new ApplicationDB();
		con = db.getConnection();
		statement = con.prepareStatement("SELECT * from reservation WHERE ssn=?");
		statement.setString(1, ssn);
		resultSet = statement.executeQuery();
		while(resultSet.next())
		{
			%>
				<tr>
				<td><%=resultSet.getString("rid") %></td>
				<td><%=resultSet.getString("username") %></td>
				<td><%=resultSet.getString("transitName") %></td>
				<td><%=resultSet.getString("scheduleid") %></td>
				<td><%=resultSet.getString("tid") %></td>
				<td><%=resultSet.getString("originSid") %></td>
				<td><%=resultSet.getString("destinationSid") %></td>
				<td><%=resultSet.getString("bookingFee") %></td>
				<td><%=resultSet.getString("totalFare") %></td>
				<td><%=resultSet.getString("bookingDate") %></td>
				<td><%=resultSet.getString("pastReservation") %></td>
				<td><%=resultSet.getString("seatNumber") %></td>
				<td><%=resultSet.getString("class") %></td>
				
				</tr>
			<% 
		}
		con.close();
		}catch(Exception e){
			//out.print(e);
		}
		
	%>
	 </table>
	 
	<form method="post" action="editReservation.jsp">
	<h2>Enter the Reservation ID you want to Edit or Delete (Part VI)</h2>
	<h3>If you'd like to create a reservation, just click ADD!</h3>
	<br>
	<input type="text" name="rid" pattern="[0-9]{9}">
	<br>
	 <p>Format is: 123456789 (9 Digit number)</p>
	
	<br>
	
	<input type="submit" name= "editButton" value="Edit">
	
	<input type="submit" name= "addButton" value="Add">
	
	<input type="submit" name= "deleteButton" value="Delete" >
	</form>
	
	
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
