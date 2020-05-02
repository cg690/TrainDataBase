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
	<label>Reservation ID (only if adding):</label>
	<input type="text" name="rid" pattern="[0-9]{9}">
	<br>
	 <p>Format is: 123456789 (9 Digit number)</p>
	
	<br>
	
	<input type="submit" name= "editButton" value="Edit">
	
	<input type="submit" name= "addButton" value="Add">
	
	<input type="submit" name= "deleteButton" value="Delete" >
	</form>
	
	
	<br>
	

	//Display Stops Table, which has a detailed schedule stop to stop. You can pick which tuple to add delay to and it will propogate	
	 <h2>Detailed Schedule, Station by Station</h2>
	 <table border = "1">
				<tr>
				<td>Transit Name</td>
				<td>Schedule ID</td>
				<td> Start Station ID</td>
				<td>Start Station Name</td>
				<td>End Station ID </td>
				<td>End Station Name</td>
				<td>Arrival Time</td>
				<td>Departure Time</td>
				<td>Monthly Fee</td>
				<td>Weekly Fee</td>
				<td>Single Trip Fee</td>
				<td>Round Trip Fee</td>
				<td>Delay</td>
				</tr>
	 <%
		try{
			//make DB query to get stops table
		ApplicationDB db = new ApplicationDB();
		con = db.getConnection();
		statement = con.prepareStatement("SELECT distinct s.transitName, s.scheduleid, s.arrivalTime, s.departureTime, s.monthly,  s.weekly, s.startSid, s.stopSid, s.singleTrip, s.roundTrip, s.delay, origin.name  AS startLoc, destination.name AS destLoc  FROM stops s,  (SELECT st.name, st.sid, s.scheduleid, s.transitName FROM station st, stops s WHERE sid = startSid) origin, (SELECT st.name, st.sid, s.scheduleid, s.transitName FROM station st, stops s WHERE sid= stopSid) destination WHERE origin.sid = s.startSid AND destination.sid = s.stopSid");
		resultSet = statement.executeQuery();
		while(resultSet.next())
		{
			%>
				<tr>
				<td><%=resultSet.getString("transitName") %></td>
				<td><%=resultSet.getString("scheduleid") %></td>
				<td><%=resultSet.getString("startSid") %></td>
				<td><%=resultSet.getString("startLoc") %></td>
				<td><%=resultSet.getString("stopSid") %></td>
				<td><%=resultSet.getString("destLoc") %></td>
				<td><%=resultSet.getString("arrivalTime") %></td>
				<td><%=resultSet.getString("departureTime") %></td>
				<td><%=resultSet.getString("monthly") %></td>
				<td><%=resultSet.getString("weekly") %></td>
				<td><%=resultSet.getString("singleTrip") %></td>
				<td><%=resultSet.getString("roundTrip") %></td>
				<td><%=resultSet.getString("delay") %></td>
				</tr>
			<% 
		}
		con.close();
		}catch(Exception e){
			//out.print(e);
		}
		
	%>
	 </table>
	 
	

	<br>
	<form method="post" action="editSchedule.jsp">
	<h2>Enter the following Schedule details (all of them) you want to Add, Edit, or Delete (Part VI)</h2>
	<br>
	<label>Transit Name:</label>
	<input type="text" name="transitName" >
	<label>Schedule ID: </label>
	<input type="number" name="scheduleid">
	<label>Starting Station ID:</label>
	<input type="number" name="startSid">
	<label>Destination Station ID: </label>
	<input type="number" name="stopSid" >
	<br>
	 <p>Please enter matching values from one of the rows in the above table to edit. <br>Schedule ID, Starting Station ID and Destination Station ID are to be input as numbers.</p>
	
	<br>
	
	<input type="submit" name= "editButton" value="Edit">
	
	<input type="submit" name= "addButton" value="Add">
	
	<input type="submit" name= "deleteButton" value="Delete" >
	</form>

	<br>
	<br>
	
	<label> Respond to questions (Part VI)</label>
	
	<form method="get" action = "replyCustomers.jsp">
		<input type="submit" value="View Customers Questions">
	</form>
	<br>
	<br>
	<a href="logout.jsp">Logout</a>
<br>

</body>
</html>
