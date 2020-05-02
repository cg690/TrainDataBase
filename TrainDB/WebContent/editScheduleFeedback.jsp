<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.traindb.pk.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Reservation Information</title>
</head>
<body>
	<%
	    
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Get the Reservation Info from the textboxes
			
			//String rid = request.getParameter("rid").equals("") ? "" : request.getParameter("rid");
			String transitName = request.getParameter("transitName").equals("") ? "" : request.getParameter("transitName");
			String scheduleid = request.getParameter("scheduleid").equals("") ? "" : request.getParameter("scheduleid");
			String startSid = request.getParameter("startSid").equals("") ? "" : request.getParameter("startSid");
			String stopSid = request.getParameter("stopSid").equals("") ? "" : request.getParameter("stopSid");
			String arrivalTime = request.getParameter("arrivalTime").equals("") ? "" : request.getParameter("arrivalTime");
			String departureTime = request.getParameter("departureTime").equals("") ? "" : request.getParameter("departureTime");
			String monthly = request.getParameter("monthly").equals("") ? "" : request.getParameter("monthly");
			String weekly = request.getParameter("weekly").equals("") ? "" : request.getParameter("weekly");
			String singleTrip = request.getParameter("singleTrip").equals("") ? "" : request.getParameter("singleTrip");
			String roundTrip = request.getParameter("roundTrip").equals("") ? "" : request.getParameter("roundTrip");
			String delay = request.getParameter("delay").equals("") ? "" : request.getParameter("delay");
			
			//session.setAttribute("rid", rid); 
			session.setAttribute("transitName", transitName);
			session.setAttribute("scheduleid", scheduleid);
			session.setAttribute("startSid", startSid);
			session.setAttribute("stopSid", stopSid);
			session.setAttribute("arrivalTime", arrivalTime);
			session.setAttribute("departureTime", departureTime);
			session.setAttribute("monthly", monthly);
			session.setAttribute("weekly", weekly);
			session.setAttribute("singleTrip", singleTrip);
			session.setAttribute("roundTrip", roundTrip);
			session.setAttribute("delay", delay);
			
				//no error, create the account
			if(session.getAttribute("op").equals("edit")){
				PreparedStatement pmst = con.prepareStatement("UPDATE stops SET transitName=?, scheduleid=?, startSid=?,stopSid=?, arrivalTime=?, departureTime=?, monthly=?, weekly=?, singleTrip=?, roundTrip=?, delay=? WHERE transitName='"+session.getAttribute("transitName")+"' scheduleid='"+session.getAttribute("scheduleid")+"' , startSid='"+session.getAttribute("startSid")+"' , stopSid='"+session.getAttribute("stopSid")+"'");
				try {
					pmst.setString(1, transitName);
					pmst.setInt(2, Integer.parseInt(scheduleid));
					pmst.setInt(3,  Integer.parseInt(startSid));
					pmst.setInt(4,  Integer.parseInt(stopSid));
					pmst.setString(5, arrivalTime);
					pmst.setString(6, departureTime);
					pmst.setString(7, monthly);
					pmst.setString(8, weekly);
					pmst.setString(9, singleTrip);
					pmst.setString(10, roundTrip);
					pmst.setString(11, delay);
					
					pmst.execute();
						
					
					out.print("Successfully Edited the stop schedule!");
				} catch (Exception e) {
					out.print("Couldn't edit");
				}
			}
			else if(session.getAttribute("op").equals("add")){
				PreparedStatement pmst = con.prepareStatement("INSERT INTO stops(transitName, scheduleid, startSid,stopSid, arrivalTime, departureTime, monthly, weekly, singleTrip, roundTrip, delay) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				try{
					out.print(session.getAttribute("transitName").toString());
					out.print(session.getAttribute("scheduleid").toString());
					out.print(session.getAttribute("startSid").toString());
					out.print(session.getAttribute("stopSid").toString());
					
					pmst.setString(1, transitName);
					pmst.setString(2, scheduleid);
					pmst.setString(3, startSid);
					pmst.setString(4, stopSid);
					pmst.setString(5, arrivalTime);
					pmst.setString(6, departureTime);
					pmst.setString(7, monthly);
					pmst.setString(8, weekly);
					pmst.setString(9, singleTrip);
					pmst.setString(10, roundTrip);
					pmst.setString(11, delay);
					
					pmst.execute();
					
					out.print("Successfully created new stop schedule");
				} catch (Exception e) {
					out.print("Couldn't create the stop schedule");
				}
			}
					  	
			//close the connection.
			db.closeConnection(con);
		} catch (Exception e) {
			out.print(e);
		}
	%>
	
	<form method="post" action="employeePage.jsp">
	<input type="submit" value="Employee Home">
	</form>
</body>
</html>