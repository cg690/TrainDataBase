<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.traindb.pk.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add/Change Reservation</title>
</head>
<body>
<%
	    
		try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			
			//Get the reservation details from textboxes
			String rid = request.getParameter("rid");
			
			if(request.getParameter("editButton")!=null){
			
			PreparedStatement st = con.prepareStatement("SELECT * FROM reservation WHERE rid = ?");
			st.setString(1, rid);
			ResultSet rs = st.executeQuery();

			if (rs.next()) {
				
				session.setAttribute("op", "edit");
				session.setAttribute("rid", rid);
				session.setAttribute("username", rs.getString("username"));
				session.setAttribute("transitName", rs.getString("transitName"));
				session.setAttribute("scheduleid", rs.getString("scheduleid"));
				session.setAttribute("tid", rs.getString("tid"));
				session.setAttribute("originSid", rs.getString("originSid"));
				session.setAttribute("destinationSid", rs.getString("destinationSid"));
				session.setAttribute("ssn", rs.getString("ssn"));
				session.setAttribute("bookingFee", rs.getString("bookingFee"));
				session.setAttribute("totalFare", rs.getString("totalFare"));
				session.setAttribute("bookingDate", rs.getString("bookingDate"));
				session.setAttribute("pastReservation", rs.getString("pastReservation"));
				session.setAttribute("seatNumber", rs.getString("seatNumber"));
				session.setAttribute("class", rs.getString("class"));
				
				out.print("Edit for reservation:" + rid);
					
					

			} else {
				//no result set from username means the user doesn't exist
				out.print("There is no Reservation associated with that Reservation ID");
				db.closeConnection(con);
				return;
			}
			}
			
			else if(request.getParameter("addButton")!=null){
				Random rnd = new Random();
				int newRid = 1 + rnd.nextInt(999999999);
				PreparedStatement st = con.prepareStatement("SELECT * FROM reservation WHERE rid=?");
				st.setString(1,Integer.toString(newRid));
				ResultSet rs = st.executeQuery();
				
				if (rs.next()) {
					out.print("Reservation with that ID already exists");
					db.closeConnection(con);
					return;

				} else {
					out.print("<h1>Adding new Reservation: "+newRid+"</h1>");
					session.setAttribute("op","add");
					session.setAttribute("rid", newRid);
					session.setAttribute("username", "");
					session.setAttribute("transitName", "");
					session.setAttribute("scheduleid", "");
					session.setAttribute("tid", "");
					session.setAttribute("originSid", "");
					session.setAttribute("destinationSid", "");
					session.setAttribute("ssn", "");
					session.setAttribute("bookingFee", "");
					session.setAttribute("totalFare", "");
					session.setAttribute("bookingDate", "");
					session.setAttribute("pastReservation", "");
					session.setAttribute("seatNumber", "");
					session.setAttribute("class", "");
				}
				
			}
			else if(request.getParameter("deleteButton")!=null){
				
				//no error, create the account
								
				PreparedStatement st = con.prepareStatement("SELECT * FROM reservation WHERE rid = ?");
				st.setString(1, rid);
				ResultSet rs = st.executeQuery();
				
				try {
					if(rs.next()){
					
					PreparedStatement pmst1 = con.prepareStatement("DELETE FROM reservation WHERE rid= ?");
					pmst1.setString(1, rid);
					pmst1.execute();
					
					out.print("Successfully Deleted Reservation");

					db.closeConnection(con);
					return;
					}
					else{
						out.print("Reservation with that ID does not exist");

						//close the connection.
						db.closeConnection(con);
						return;
					}
					
				} catch (Exception e) {
					out.print("Reservation with that ID does not exist");

					//close the connection.
					db.closeConnection(con);
					return;
				}
			}
			//close the connection.
			db.closeConnection(con);
		} catch (Exception e) {
			out.print(e);
		}
	%>
	<br>
	<h2>Reservation Detail</h2>
	<form method="post" action="editReservationFeedback.jsp">
	<br>
	<strong>Username</strong>
	<input type="text" name="username" value = <%=session.getAttribute("username")%>>
	<br>
	<br>
	<strong>Transit Name</strong>
	<input type="text" name="transitName" value = <%=session.getAttribute("transitName")%>>
	<br>
	<br>
	<strong>Schedule ID</strong>
	<input type="text" name="scheduleid" value = <%=session.getAttribute("scheduleid")%>>
	<br><br>
	<strong>Train ID</strong>
	<input type="text" name="tid" value = <%=session.getAttribute("tid")%>>
	<br><br>
	<strong>Origin Station  ID</strong>
	<input type="text" name="originSid" value = <%=session.getAttribute("originSid")%>>
	<br><br>
	<strong>Destination ID</strong>
	<input type="text" name="destinationSid" value = <%=session.getAttribute("destinationSid")%>>
	<br><br>
	<strong>Customer Rep SSN</strong>
	<input type="text" name="ssn" value = <%=session.getAttribute("ssn")%>>
	<br><br>
	<strong>Booking Fee</strong>
	<input type="text" name="bookingFee" value = <%=session.getAttribute("bookingFee")%>>
	<br>
	<br>
	<strong>Total Fare</strong>
	<input type="text" name="totalFare" value = <%=session.getAttribute("totalFare")%>>
	<br>
	<br>
	<strong>Booking Date</strong>
	<input type="text" name="bookingDate" value = <%=session.getAttribute("bookingDate")%>>
	<br>
	<br>
	<strong>Past Reservation</strong>
	<input type="text" name="pastReservation" value = <%=session.getAttribute("pastReservation")%>>
	<br>
	<br>
	<strong>Seat Number</strong>
	<input type="text" name="seatNumber" value = <%=session.getAttribute("seatNumber")%>>
	<br>
	<br>
	<strong>Class</strong>
	<input type="text" name="class" value = <%=session.getAttribute("class")%>>
	<br>
	<input type="submit" value="Done">
	</form>
<br>

</body>
</html>