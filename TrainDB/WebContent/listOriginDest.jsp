<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.traindb.pk.*" %>
<%@ page import ="java.util.ArrayList"%>
<%@page import="java.util.Map" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="javax.servlet.http.HttpServletResponse"%>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Schedule Search</title>
</head>
<body>
<%
Connection con = null;
PreparedStatement statement = null;
ResultSet resultSet = null;
%>

<h2>List of Schedules which have the given Origin and Destination in their paths.</h2>
<br>

<table>
<tr>
<th>Transit Name</th>
<th>Schedule ID</th>
<th>Train ID</th>
<th>Origin Station ID</th>
<th>Destination Station ID</th>
<th>Travel Time</th>
<th>Available Seats</th>
<th>Departure Time</th>
<th>Arrival Time</th>
</tr>
<%
	try{
		ApplicationDB db = new ApplicationDB();
		con = db.getConnection();
	//recieve relevant info
		String originStation = request.getParameter("startSid").toString();
		String destStation = request.getParameter("stopSid").toString();
	
		PreparedStatement st1 = con.prepareStatement("SELECT *, COUNT(*) as Cnt FROM stops WHERE startSid=? OR stopSid =? HAVING Cnt >=2;");
		st1.setInt(1, Integer.parseInt(originStation));
		st1.setInt(2, Integer.parseInt(destStation));
		ResultSet rs = st1.executeQuery();
		while(rs.next())
		{
			
			PreparedStatement st2 = con.prepareStatement("SELECT * from schedule WHERE transitName=? AND scheduleid=?");
			st2.setString(1,rs.getString("transitName"));
			st2.setInt(2, Integer.parseInt(rs.getString("scheduleid")));
			resultSet = st2.executeQuery();
			
			while(resultSet.next()){
			%>
				<tr>
				<td><%=resultSet.getString("transitName") %></td>
				<td><%=resultSet.getString("scheduleid") %></td>
				<td><%=resultSet.getString("tid") %></td>
				<td><%=resultSet.getString("originSid") %></td>
				<td><%=resultSet.getString("destinationSid") %></td>
				<td><%=resultSet.getString("travelTime") %></td>
				<td><%=resultSet.getString("availableSeats") %></td>
				<td><%=resultSet.getString("departureTime") %></td>
				<td><%=resultSet.getString("arrivalTime") %></td>
				</tr>
			<% 
			}
		}
		con.close();
	}
catch(Exception e){
	out.print(e);
	out.print("\n Error getting data.");
}

%>
</table>


<form method="get" action = "employeePage.jsp">
		<input type="submit" value="Return Home">
</form>


</body>
</html>