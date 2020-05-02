<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.traindb.pk.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
Connection con = null;
Statement statement = null;
ResultSet resultSet = null;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Retrieve Schedules</title>
	</head>

	<body>
		<table border = "1">
		<tr>
		<td>Transit Name</td>
		<td>Schedule #</td>
		<td>Train #</td>
		<td>Origin Station</td>
		<td>Destination Station</td>
		<td>Travel Time</td>
		<td>Available Seats</td>
		<td>Departure Time</td>
		<td>Arrival Time</td>
		</tr>
		
		
			<%
				try{
					ApplicationDB schedules = new ApplicationDB();
					con = schedules.getConnection();
					statement = con.createStatement();
					session.setAttribute("username", "Arsiluk");
					
					//String query = "SELECT * FROM TrainRDBMS.schedule";
					String query = "SELECT DISTINCT schedule.transitName, schedule.scheduleid, tid, origins.name AS originName, destinations.name AS destinationName, travelTime, availableSeats, departureTime, arrivalTime FROM TrainRDBMS.schedule, (SELECT name, sid, scheduleid, transitName FROM TrainRDBMS.station, TrainRDBMS.schedule WHERE sid = originSid) origins, (SELECT name, sid, scheduleid FROM TrainRDBMS.station, TrainRDBMS.schedule WHERE sid = destinationSid) destinations WHERE schedule.scheduleid = origins.scheduleid AND origins.scheduleid = destinations.scheduleid AND schedule.originSid = origins.sid AND schedule.destinationSid = destinations.sid;";					
					resultSet = statement.executeQuery(query);
					while(resultSet.next()){
						%>
						<tr>
							<td><%=resultSet.getString("transitName") %></td>
							<td><%=resultSet.getString("scheduleid") %> </td>
							<td><%=resultSet.getString("tid") %></td>
							<td> <%=resultSet.getString("originName") %></td>
							<td><%=resultSet.getString("destinationName") %></td>
							<td><%=resultSet.getString("travelTime") %></td>
							<td><%=resultSet.getString("availableSeats") %></td>
							<td><%=resultSet.getString("departureTime") %></td>
							<td><%=resultSet.getString("arrivalTime") %></td>
						</tr>
						<%  
						
					}
					
					
				con.close();
				}catch(Exception e){
					e.printStackTrace();
				}
			%>
	
		</table>
		<br>
		<p>View Stops for a specific Transit Line :</p>	
		<br>
		<form method = "post" action = "viewStops.jsp">
		
		<label>Transit Name</label>
		<input type = "text"
				name  = "transitName"
				 />
		
		<br>
		<label>Desired Train</label>
		<input type = "text" name = "tid"/>
		<br/>
		<label>Desired Schedule #</label>
		<input type = "text" name = "scheduleid"/>
		<br>
		<input type = "submit" value = "View Stops" />
		</form>
		
		<br>
		<form method = "get" action = "home.jsp">
		<input type = "submit" value = "Return Home"/>
		</form>
		
		<br>
		
		<form method = "get" action = "viewReservations.jsp">
		<input type = "submit" value = "View Reservations"/>
		</form>
				
	</body>
</html>
