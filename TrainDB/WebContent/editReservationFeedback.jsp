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
			String username= request.getParameter("username").equals("") ? "" : request.getParameter("username");
			String transitName = request.getParameter("transitName").equals("") ? "" : request.getParameter("transitName");
			String scheduleid = request.getParameter("scheduleid").equals("") ? "" : request.getParameter("scheduleid");
			String tid = request.getParameter("tid").equals("") ? "" : request.getParameter("tid");
			String originSid = request.getParameter("originSid").equals("") ? "" : request.getParameter("originSid");
			String destinationSid = request.getParameter("destinationSid").equals("") ? "" : request.getParameter("destinationSid");
			String ssn = request.getParameter("ssn").equals("") ? "" : request.getParameter("ssn");
			String bookingFee = request.getParameter("bookingFee").equals("") ? "" : request.getParameter("bookingFee");
			String totalFare = request.getParameter("totalFare").equals("") ? "" : request.getParameter("totalFare");
			String bookingDate = request.getParameter("bookingDate").equals("") ? "" : request.getParameter("bookingDate");
			String pastReservation = request.getParameter("pastReservation").equals("") ? "" : request.getParameter("pastReservation");
			String seatNumber = request.getParameter("seatNumber").equals("") ? "" : request.getParameter("seatNumber");
			String classN = request.getParameter("class").equals("") ? "" : request.getParameter("class");
			
			//session.setAttribute("rid", rid); 
			session.setAttribute("username", username);
			session.setAttribute("transitName", transitName);
			session.setAttribute("scheduleid",scheduleid);
			session.setAttribute("tid", tid);
			session.setAttribute("originSid", originSid);
			session.setAttribute("destinationSid",destinationSid);
			session.setAttribute("ssn",ssn);
			session.setAttribute("bookingFee", bookingFee);
			session.setAttribute("totalFare", totalFare);
			session.setAttribute("bookingDate", bookingDate);
			session.setAttribute("pastReservation", pastReservation);
			session.setAttribute("seatNumber", seatNumber);
			session.setAttribute("class", classN);
			
				//no error, create the account
			if(session.getAttribute("op").equals("edit")){
				PreparedStatement pmst = con.prepareStatement("UPDATE reservation SET username=?, transitName=?, scheduleid=?, tid=?, originSid=?, destinationSid=?, ssn=?, bookingFee=?, totalFare=?, bookingDate=?, pastReservation=?, seatNumber=?, class=? WHERE rid='"+session.getAttribute("rid")+"'");
				try {
					pmst.setString(1, username);
					pmst.setString(2, transitName);
					pmst.setString(3, scheduleid);
					pmst.setString(4, tid);
					pmst.setString(5, originSid);
					pmst.setString(6, destinationSid);
					pmst.setString(7, ssn);
					pmst.setString(8, bookingFee);
					pmst.setString(9, totalFare);
					pmst.setString(10, bookingDate);
					pmst.setString(11, pastReservation);
					pmst.setString(12, seatNumber);
					pmst.setString(13, classN);
					
					pmst.execute();
					
					out.print("Successfully Edited the reservation!");
				} catch (Exception e) {
					out.print("Couldn't edit");
				}
			}
			else if(session.getAttribute("op").equals("add")){
				PreparedStatement pmst = con.prepareStatement("INSERT INTO reservation(rid, username, transitName, scheduleid, tid, originSid, destinationSid, ssn, bookingFee, totalFare, bookingDate, pastReservation, seatNumber, class) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				try{
					out.print(session.getAttribute("rid").toString());
					
					pmst.setString(1, session.getAttribute("rid").toString());
					pmst.setString(2, username);
					pmst.setString(3, transitName);
					pmst.setString(4, scheduleid);
					pmst.setString(5, tid);
					pmst.setString(6, originSid);
					pmst.setString(7, destinationSid);
					pmst.setString(8, ssn);
					pmst.setString(9, bookingFee);
					pmst.setString(10, totalFare);
					pmst.setString(11, bookingDate);
					pmst.setString(12, pastReservation);
					pmst.setString(13, seatNumber);
					pmst.setString(14, classN);
					
					pmst.execute();
					
					out.print("Successfully created new Reservation");
				} catch (Exception e) {
					out.print("Couldn't create the reservation");
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