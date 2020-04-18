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
		<title>View Stops</title>
	</head>
	
		<body>
		
			<table border = "1">
				<tr>
				<td>Transit Name</td>
				<td>Start Name</td>
				<td>Stop Name</td>
				<td>Arrival Time</td>
				<td>Departure Time</td>
				<td>Monthly</td>
				<td>Weekly</td>
				<td>Single Trip</td>
				<td>Round Trip</td>
				</tr>
				
				<%
					try{
					ApplicationDB schedules = new ApplicationDB();
					con = schedules.getConnection();
					statement = con.createStatement();
					String transitName = request.getParameter("transitName").equals("")? null : request.getParameter("transitName");
					session.setAttribute("transitName",transitName);
					String tid = request.getParameter("tid");
					session.setAttribute("tid",tid);
					String scheduleid = request.getParameter("scheduleid");
					session.setAttribute("scheduleid",scheduleid);
					
					if(transitName.equals(""))
					{
						out.print("Please enter a transit name <br/>");
						throw new Exception();
					}
					if(tid.equals(""))
					{
						out.print("Please enter a valid tid <br/>");
						throw new Exception();
					}
					
					//String query = "SELECT * FROM TrainRDBMS.stops WHERE transitName = '" + transitName + "' AND scheduleid = " + scheduleid + ";";
					String query = "SELECT stops.transitName, stops.scheduleid, origins.name AS startName, destinations.name AS stopName, arrivalTime, departureTime, monthly, weekly, singleTrip, roundTrip FROM TrainRDBMS.stops, (SELECT name, sid, scheduleid, transitName FROM TrainRDBMS.station, TrainRDBMS.stops WHERE sid = startSid) origins, (SELECT name, sid, scheduleid, transitName FROM TrainRDBMS.station, TrainRDBMS.stops WHERE sid = stopSid) destinations WHERE stops.transitName = '" + transitName + "' AND origins.transitName = stops.transitName AND destinations.transitName = origins.transitName AND stops.scheduleid = " + scheduleid + " AND stops.scheduleid = origins.scheduleid AND origins.scheduleid = destinations.scheduleid AND stops.startSid = origins.sid AND stops.stopSid = destinations.sid;";
    
					resultSet = statement.executeQuery(query);
					if(!resultSet.next())
					{
						out.print("Please enter a valid Transit Name, Train, and Schedule Number, no data could be found <br>");
						throw new Exception();
					}
					resultSet = statement.executeQuery(query);
					while(resultSet.next())
					{
						%>
							<tr>
							<td><%=resultSet.getString("transitName") %></td>
							<td><%=resultSet.getString("startName") %></td>
							<td><%=resultSet.getString("stopName") %></td>
							<td><%=resultSet.getString("arrivalTime") %></td>
							<td><%=resultSet.getString("departureTime") %></td>
							<td><%=resultSet.getString("monthly") %></td>
							<td><%=resultSet.getString("weekly") %></td>
							<td><%=resultSet.getString("singleTrip") %></td>
							<td><%=resultSet.getString("roundTrip") %></td>
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
			<br>
			
			<form method = "post" action = "ticketPurchased.jsp">
			
				<label>Enter desired Origin: </label>
				<input type = "text" name = "desiredOrigin"/>
				
				<br>
				
				<label>Enter desired Destination: </label>
				<input type = "text" name = "desiredDestination"/>
				<br>
				<br>
				
				<label>Is this reservation for a child/senior/disabled?</label>
				
				<input type = "checkbox" name = "Yes" value = "Yes"/>
				
				<br>
				<br>
				
				<label>Round Trip, Single Trip, Monthly Pass, or Weekly Pass?</label>
				<br>
				<input type = "checkbox"  name = "roundTrip" value = "Round"/>
				<label for = "roundTrip"> Round </label>
				
				<br>
				<input type = "checkbox" name = "singleTrip" value = "Single"/>
				<label for = "singleTrip"> Single </label>
				
				<br> 
				<input type = "checkbox" name = "monthly" value = "Monthly"/>
				<label for = "monthly">Monthly Pass</label>
				
				<br>
				
				<input type = "checkbox" name = "weekly" value = "Weekly"/>
				<label for = "weekly">Weekly Pass</label>
								
				<br>
				<br>
				<label>Please select a seat class</label>
				<br>
				<input type = "checkbox" name = "economy" value = "economy"/>
				<label for = "economy"> Economy </label>
				<br>
				<input type = "checkbox" name = "business" value = "business"/>
				<label for = "business"> Business </label>
				<br>
				<input type = "checkbox" name = "first" value = "first"/>
				<label for = "first"> First </label>
				<br>
				<label>Would you like a customer representative?</label>
				<br>
				<input type = "checkbox" name = "customerRep" value = "customerRep"/>
				<label for = "customerRep">Yes</label>
				<br>
				<input type = "submit" value = "Purchase"/>
				<br>
				<br>
				
				
				
			</form>
			
			<form method = "get" action = "retrieveSchedules.jsp">
					
					<br>
					
					<label>Go back to available schedules</label>
					
					<input type = "submit" value = "Back to schedules"/>
					
			</form>
			
	
		</body>
	
</html>