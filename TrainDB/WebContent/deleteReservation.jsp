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
int result = 0;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	</head>
	<body>
		<%
			try{
			ApplicationDB reservation = new ApplicationDB();
			con = reservation.getConnection();
			statement = con.createStatement();
			
			String username = session.getAttribute("username") == null ? "" : session.getAttribute("username").toString();
			String rid = request.getParameter("reservationID");
			if(rid.equals("")){
				throw new Exception();
			}
			String query = "SELECT rid FROM TrainRDBMS.reservation WHERE username = '" + username + "' AND rid = " + rid + " AND pastReservation = TRUE;";
			resultSet = statement.executeQuery(query);
			if(resultSet.next())
			{
				//out.print("Cannot delete a reservation you already deleted <br/>");
				throw new Exception();
			}
			query = "UPDATE TrainRDBMS.reservation SET pastReservation = TRUE WHERE username = '" + username + "' AND rid = " + rid + ";";
			result = statement.executeUpdate(query);
			con.close();
	        response.sendRedirect("viewReservations.jsp");
			}
			catch(Exception e)
			{
		        response.sendRedirect("viewReservations.jsp");
			}
		%>
	</body>
	
</html>