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
		<title>View Reservations</title>
	</head>
	
		<body>
			<p>Current Reservations</p>
			<br/>
			<table border = "1">
				<tr>
					<td>rid</td>
					<td>transitName</td>
					<td>scheduleid</td>
					<td>tid</td>
					<td>originSid</td>
					<td>destinationSid</td>
					<td>bookingFee</td>
					<td>totalFare</td>
					<td>bookingDate</td>
					<td>seatNumber</td>
					<td>seatClass</td>
				</tr>
				<%
					try{
					ApplicationDB reservation = new ApplicationDB();
					con = reservation.getConnection();
					statement = con.createStatement();
					
					String username = session.getAttribute("username") == null ? "" : session.getAttribute("username").toString();

					
					String query = "SELECT reservation.rid, username, transitName, scheduleid, tid, originName.name AS originStation, destinationName.name AS destinationStation, bookingFee, totalFare, bookingDate, seatNumber, class FROM TrainRDBMS.reservation, (SELECT name, rid FROM TrainRDBMS.station JOIN TrainRDBMS.reservation ON station.sid = reservation.originSid)originName, (SELECT name, rid FROM TrainRDBMS.station JOIN TrainRDBMS.reservation ON station.sid = reservation.destinationSid)destinationName WHERE reservation.rid = originName.rid AND originName.rid = destinationName.rid AND reservation.username = '" + username + "' AND pastReservation = FALSE;";

					resultSet = statement.executeQuery(query);
					
					while(resultSet.next())
					{
						%>
						<tr>
						<td><%=resultSet.getString("rid") %></td>
						<td><%= resultSet.getString("transitName") %></td>
						<td><%=resultSet.getString("scheduleid") %></td>
						<td><%= resultSet.getString("tid") %> </td>
						<td><%= resultSet.getString("originStation") %> </td>
						<td> <%= resultSet.getString("destinationStation") %> </td>
						<td><%= resultSet.getString("bookingFee") %></td>
						<td><%= resultSet.getString("totalFare") %></td>
						<td><%= resultSet.getString("bookingDate") %></td>
						<td> <%= resultSet.getString("seatNumber") %></td>
						<td> <%= resultSet.getString("class") %></td>
						</tr>
						<%
					}
					con.close();
					}catch(Exception e)
					{
						out.print(e + "<br/>");
					}
				%>
			</table>
			<br/>
			<br/>
			
			<p>Past Reservations</p>
			<br/>
			<table border = "1">
				<tr>
					<td>rid</td>
					<td>transitName</td>
					<td>scheduleid</td>
					<td>tid</td>
					<td>originSid</td>
					<td>destinationSid</td>
					<td>bookingFee</td>
					<td>totalFare</td>
					<td>bookingDate</td>
					<td>seatNumber</td>
					<td>seatClass</td>
				</tr>
				<%
					try
					{
						ApplicationDB reservation = new ApplicationDB();
						con = reservation.getConnection();
						statement = con.createStatement();
						
						String username = session.getAttribute("username") == null ? "" : session.getAttribute("username").toString();

						
						//String query = "SELECT * FROM TrainRDBMS.reservation WHERE username = '" + username + "'AND pastReservation = TRUE;";
						String query = "SELECT reservation.rid, username, transitName, scheduleid, tid, originName.name AS originStation, destinationName.name AS destinationStation, bookingFee, totalFare, bookingDate, seatNumber, class FROM TrainRDBMS.reservation, (SELECT name, rid FROM TrainRDBMS.station JOIN TrainRDBMS.reservation ON station.sid = reservation.originSid)originName, (SELECT name, rid FROM TrainRDBMS.station JOIN TrainRDBMS.reservation ON station.sid = reservation.destinationSid)destinationName WHERE reservation.rid = originName.rid AND originName.rid = destinationName.rid AND reservation.username = '" + username + "' AND pastReservation = TRUE;";
						resultSet = statement.executeQuery(query);
						
						while(resultSet.next())
						{
							%>
							<tr>
							<td><%=resultSet.getString("rid") %></td>
							<td><%= resultSet.getString("transitName") %></td>
							<td><%=resultSet.getString("scheduleid") %></td>
							<td><%= resultSet.getString("tid") %> </td>
							<td><%= resultSet.getString("originStation") %> </td>
							<td> <%= resultSet.getString("destinationStation") %> </td>
							<td><%= resultSet.getString("bookingFee") %></td>
							<td><%= resultSet.getString("totalFare") %></td>
							<td><%= resultSet.getString("bookingDate") %></td>
							<td> <%= resultSet.getString("seatNumber") %></td>
							<td> <%= resultSet.getString("class") %></td>
						</tr>
							<%
						}
						con.close();
						
					}catch(Exception e)
					{
						
					}
				%>
			</table>
			
			<p>Enter the ID of the reservation you wish to cancel</p>
			<form method = "post" action = "deleteReservation.jsp">
			<input type = "text" name = "reservationID"/>
			<br>
			<input type  = "submit" value = "Delete Reservation"/>
			</form>
			
			<br/>
			<br/>
			
			<form method = "get" action = "retrieveSchedules.jsp">
			<input type = "submit" value = "View Available Schedules"/>
			</form>
			
			<br/>
			<br/>
			
			<form method = "get" action = "home.jsp">
			<input type = "submit" value = "Return to your profile"/>
			</form>
			
		</body>
</html>