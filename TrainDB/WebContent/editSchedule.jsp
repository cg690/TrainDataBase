<%@ page language="java"  contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.traindb.pk.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add/Change Schedule</title>
</head>
<body>
<%
	    
		try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			
			//Get the schedule details from textboxes
			String transitName = request.getParameter("transitName");
			String scheduleid = request.getParameter("scheduleid");
			String startSid = request.getParameter("startSid");
			String stopSid = request.getParameter("stopSid");
			
			if(request.getParameter("editButton")!=null){
			
			PreparedStatement st = con.prepareStatement("SELECT * FROM stops WHERE transitName = ?, scheduleid = ?, startSid =?, stopSid=?");
			st.setString(1, transitName);
			st.setInt(2,Integer.parseInt(scheduleid));
			st.setInt(3,Integer.parseInt(startSid));
			st.setInt(4,Integer.parseInt(stopSid));
			
			ResultSet rs = st.executeQuery();

			if (rs.next()) {
				session.setAttribute("op", "edit");
				session.setAttribute("transitName", transitName);
				session.setAttribute("scheduleid", rs.getString("scheduleid"));
				session.setAttribute("startSid", rs.getString("startSid"));
				session.setAttribute("stopSid", rs.getString("stopSid"));
				session.setAttribute("arrivalTime", rs.getString("arrivalTime"));
				session.setAttribute("departureTime", rs.getString("departureTime"));
				session.setAttribute("monthly", rs.getString("monthly"));
				session.setAttribute("weekly", rs.getString("weekly"));
				session.setAttribute("singleTrip", rs.getString("singleTrip"));
				session.setAttribute("roundTrip", rs.getString("roundTrip"));
				session.setAttribute("delay", rs.getString("delay"));
				
				out.print("Edit for Schedue with Transit Name: "+transitName+"| Schedule ID: "+scheduleid+"| Start Station ID: "+startSid+"| Stop station ID: "+stopSid);
					
					

			} else {
				//no result set from username means the user doesn't exist
				out.print("There is no Schedule associated with those attributes");
				db.closeConnection(con);
				return;
			}
			}
			
			else if(request.getParameter("addButton")!=null){
				PreparedStatement st = con.prepareStatement("SELECT * FROM stops WHERE transitName=?, scheduleid=?, startSid=?, stopSid=?");
				st.setString(1,transitName);
				st.setString(2,scheduleid);
				st.setString(3,startSid);
				st.setString(4,stopSid);
				ResultSet rs = st.executeQuery();
				
				if (rs.next()) {
					out.print("A Schedule with that ID already exists");
					db.closeConnection(con);
					return;

				} else {
					out.print("Adding new Schedule");
					session.setAttribute("op","add");
					session.setAttribute("transitName", "");
					session.setAttribute("scheduleid", "");
					session.setAttribute("startSid", "");
					session.setAttribute("stopSid", "");
					session.setAttribute("arrivalTime", "");
					session.setAttribute("departureTime", "");
					session.setAttribute("monthly", "");
					session.setAttribute("weekly", "");
					session.setAttribute("singleTrip", "");
					session.setAttribute("roundTrip", "");
					session.setAttribute("delay", "");
				}
				
			}
			else if(request.getParameter("deleteButton")!=null){
				
				//no error, create the account
								
				PreparedStatement st = con.prepareStatement("SELECT * FROM stops WHERE transitName=?, scheduleid=?, startSid=?, stopSid=?");
				st.setString(1,transitName);
				st.setString(2,scheduleid);
				st.setString(3,startSid);
				st.setString(4,stopSid);
				ResultSet rs = st.executeQuery();
				
				try {
					if(rs.next()){
					
					PreparedStatement pmst1 = con.prepareStatement("DELETE * FROM stops WHERE transitName=?, scheduleid=?, startSid=?, stopSid=?");
					pmst1.setString(1,transitName);
					pmst1.setString(2,scheduleid);
					pmst1.setString(3,startSid);
					pmst1.setString(4,stopSid);
					pmst1.execute();
					
					out.print("Successfully Deleted Reservation");

					db.closeConnection(con);
					return;
					}
					else{
						out.print("Reservation with that ID does not exist (make sure you filled out all the fields!)");

						//close the connection.
						db.closeConnection(con);
						return;
					}
					
				} catch (Exception e) {
					out.print("Error: reservation with that id doesn't exist. Make sure you filled out all the fields! ");

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
	<h2>Schedule Detail</h2>
	<form method="post" action="editScheduleFeedback.jsp">
	<br>
	<strong>Transit Name</strong>
	<input type="text" name="transitName" value = <%=session.getAttribute("transitName")%>>
	<br>
	<br>
	<strong>Schedule ID</strong>
	<input type="text" name="scheduleid" value = <%=session.getAttribute("scheduleid")%>>
	<br><br>
	<strong>Origin Station  ID</strong>
	<input type="text" name="startSid" value = <%=session.getAttribute("startSid")%>>
	<br><br>
	<strong>Destination ID</strong>
	<input type="text" name="stopSid" value = <%=session.getAttribute("stopSid")%>>
	<br><br>
	<strong>Arrival Time</strong>
	<input type="text" name="arrivalTime" value = <%=session.getAttribute("arrivalTime")%>>
	<br>
	<br>
	<strong>Departure Time</strong>
	<input type="text" name="departureTime" value = <%=session.getAttribute("departureTime")%>>
	<br>
	<br>
	<strong>Monthly Fare</strong>
	<input type="text" name="monthly" value = <%=session.getAttribute("monthly")%>>
	<br><br>
	<strong>Weekly Fare</strong>
	<input type="text" name="weekly" value = <%=session.getAttribute("weekly")%>>
	<br>
	<br>
	<strong>Single Trip</strong>
	<input type="text" name="singleTrip" value = <%=session.getAttribute("singleTrip")%>>
	<br>
	<br>
	<strong>Round Trip</strong>
	<input type="text" name="roundTrip" value = <%=session.getAttribute("roundTrip")%>>
	<br>
	<br>
	<strong>Delay</strong>
	<input type="text" name="delay" value = <%=session.getAttribute("delay")%>>
	<br>
	
	<input type="submit" value="Done">
	</form>
<br>

</body>
</html>