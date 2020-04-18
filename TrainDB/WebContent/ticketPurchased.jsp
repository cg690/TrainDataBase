<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.traindb.pk.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.text.*"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>

<% 
	Connection con = null;
	Statement statement = null;
	ResultSet rs = null;
	int result = 0;
	String query = "";
	String query1 = "";
	double economy = 5;
	double business = 10;
	double first = 15;
	double bookingFee = 9;
	Random rnd = new Random();
	int rid = 1 + rnd.nextInt(999999999);
	int seatNumber = 0;
	double singleOrRoundFee = 0;
	String seatClass = "";
	boolean seatTaken = true;
	String customerRepSSN = "";
	double classCost = 0;
	int originNum = 0;
	int destinationNum = 0;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Ticket Purchase</title>
	</head>
		<body>
			<h1>Your Purchase</h1>
			<%
				try{
					ApplicationDB schedules = new ApplicationDB();
					con = schedules.getConnection();
					statement = con.createStatement();
					
					String username = session.getAttribute("username") == null ? "" : session.getAttribute("username").toString();
					String transitName = session.getAttribute("transitName") == null? "" : session.getAttribute("transitName").toString();
					String tid = session.getAttribute("tid") == null? "" : session.getAttribute("tid").toString();
					String scheduleid = session.getAttribute("scheduleid") == null ? "" : session.getAttribute("scheduleid").toString();
					
					//out.print("We are getting the station names now... <br>");
					String desiredOrigin = request.getParameter("desiredOrigin");
					String desiredDestination = request.getParameter("desiredDestination");
					//out.print("Desired origin = " + desiredOrigin + "<br>");
					//out.print("Desired origin = " + desiredDestination + "<br>");

					//out.print("Getting the sids now... <br>");
					
					query = "SELECT sid FROM TrainRDBMS.station, TrainRDBMS.stops WHERE startSid = sid AND name = '" + desiredOrigin + "';";
					
					//out.print("Getting the origin ID now...<br>");
					rs = statement.executeQuery(query);
					//out.print("Getting the origin ID now for real...<br>");

					if(!rs.next())
					{
						out.print("Error that station name doesn't appear in the list of stops <br>");
						throw new Exception();
					}

					//originNum = rs.getInt(1);
					desiredOrigin = rs.getString(1);
					
					//out.print("Origin Station = " + desiredOrigin + "<br>");
					
					query = "SELECT DISTINCT sid FROM TrainRDBMS.station, TrainRDBMS.stops WHERE stopSid = sid AND name = '" + desiredDestination + "';";
					rs = statement.executeQuery(query);
					//rs.next();
					if(!rs.next())
					{
						out.print("Error that station name doesn't appear in the list of stops <br>");
						throw new Exception();
					}
					desiredDestination = rs.getString(1);

					//out.print(transitName + "<br/>");
					
					
					
					
					
					if(transitName == "")
					{
						out.print("Error please enter a Transit to take");
						throw new Exception();
						
					}
					
					query = "SELECT availableSeats FROM TrainRDBMS.schedule WHERE transitName = '" + transitName + "' AND scheduleid = " + scheduleid + ";";
					rs = statement.executeQuery(query);
					rs.next();
					//out.print(rs.getInt(1)+ "</br>");
					if(rs.getInt(1)==0)
					{
						out.print("Error no available seats on this Transit");
						throw new Exception();
					}
					
					
					
					
					query = "UPDATE TrainRDBMS.schedule SET availableSeats = availableSeats - 1 WHERE transitName = '" + transitName + "' AND tid = " + tid + " AND scheduleid = " + scheduleid + ";";

					result = statement.executeUpdate(query);
					
					
					double travelFee = 0;
					
					if(request.getParameterValues("singleTrip")!=null)
					{
						if(request.getParameterValues("roundTrip")!=null || request.getParameterValues("weekly")!=null || request.getParameterValues("monthly")!=null)
						{
							out.print("Please choose only Weekly, Monthly, Single, or Round trip, not more than one");
							con.close();
							throw new Exception();
						}
						//query = "SELECT singleTrip FROM TrainRDBMS.stops WHERE scheduleid = " + scheduleid + " AND transitName = '" + transitName + "' AND startSid = " + desiredOrigin + " AND stopSid = " + desiredDestination + ";";
						query =  "SELECT singleTrip FROM TrainRDBMS.stops WHERE scheduleid = " + scheduleid + " AND transitName = '" + transitName + "' AND startSid =  " + desiredOrigin + ";";
						query1 = "SELECT singleTrip FROM TrainRDBMS.stops WHERE scheduleid = " + scheduleid + " AND transitName = '" + transitName + "' AND stopSid =  " + desiredDestination + ";";
					}
					else if(request.getParameterValues("roundTrip")!=null)
					{
						if(request.getParameterValues("weekly")!=null || request.getParameterValues("monthly")!=null)
						{
							out.print("Please choose only Weekly, Monthly, Single, or Round trip, not more than one");
							con.close();
							throw new Exception();
						}
						//query = "SELECT roundTrip FROM TrainRDBMS.stops WHERE scheduleid = " + scheduleid + " AND transitName = '" + transitName + "' AND startSid = " + desiredOrigin + " AND stopSid = " + desiredDestination + ";";
						query =  "SELECT roundTrip FROM TrainRDBMS.stops WHERE scheduleid = " + scheduleid + " AND transitName = '" + transitName + "' AND startSid =  " + desiredOrigin + ";";
						query1 = "SELECT roundTrip FROM TrainRDBMS.stops WHERE scheduleid = " + scheduleid + " AND transitName = '" + transitName + "' AND stopSid =  " + desiredDestination + ";";
					}
					else if(request.getParameterValues("weekly")!=null)
					{
						if(request.getParameterValues("monthly")!=null)
						{
							out.print("Please choose only Weekly, Monthly, Single, or Round trip, not more than one");
							con.close();
							throw new Exception();
						}
						//query = "SELECT weekly FROM TrainRDBMS.stops WHERE scheduleid = " + scheduleid + " AND transitName = '" + transitName + "' AND startSid = " + desiredOrigin + " AND stopSid = " + desiredDestination + ";";
						query =  "SELECT weekly FROM TrainRDBMS.stops WHERE scheduleid = " + scheduleid + " AND transitName = '" + transitName + "' AND startSid =  " + desiredOrigin + ";";
						query1 = "SELECT weekly FROM TrainRDBMS.stops WHERE scheduleid = " + scheduleid + " AND transitName = '" + transitName + "' AND stopSid =  " + desiredDestination + ";";
					}
					else if(request.getParameterValues("monthly")!=null)
					{
						//query = "SELECT monthly FROM TrainRDBMS.stops WHERE scheduleid = " + scheduleid + " AND transitName = '" + transitName + "' AND startSid = " + desiredOrigin + " AND stopSid = " + desiredDestination + ";";
						query =  "SELECT monthly FROM TrainRDBMS.stops WHERE scheduleid = " + scheduleid + " AND transitName = '" + transitName + "' AND startSid =  " + desiredOrigin + ";";
						query1 = "SELECT monthly FROM TrainRDBMS.stops WHERE scheduleid = " + scheduleid + " AND transitName = '" + transitName + "' AND stopSid =  " + desiredDestination + ";";
					}
					else
					{
						out.print("Please choose one of Weekly, Monthly, Single, or Round trip");
						con.close();
						throw new Exception();
					}
					
					rs = statement.executeQuery(query);
					rs.next();
					travelFee = rs.getDouble(1);
					rs = statement.executeQuery(query1);
					rs.next();
					travelFee += rs.getDouble(1);
					travelFee /= 2;
					travelFee += bookingFee;
					
					
					
					if(request.getParameterValues("economy")!=null)
					{
						if(request.getParameterValues("business")!=null || request.getParameter("first")!=null)
						{
							out.print("Please only select 1 seating class <br/>");
							throw new Exception();
						}
						out.print("You chose economy class seating <br/>");
						seatClass = "'economy'";
						classCost = economy;
					}
					else if(request.getParameterValues("business")!=null)
					{
						if(request.getParameterValues("first")!=null)
						{
							out.print("Please only select 1 seating class <br/>");
							throw new Exception();
						}
						out.print("You chose business class seating <br/>");
						seatClass = "'business'";
						classCost = business;

					}
					else if(request.getParameterValues("first")!=null)
					{
						out.print("You chose first class seating <br/>");
						seatClass = "'first'";
						classCost = first;

					}
					else
					{
						out.print("Please select a seating class.");
						throw new Exception();
					}
					travelFee += classCost;
					
					if(request.getParameterValues("Yes")!=null)
					{
						out.print("You are someone eligable for a discount </br>");
						travelFee *= 0.4;
					}

					//query = "SELECT * FROM TrainRDBMS.stops WHERE sc = " + scheduleid + " AND transitName = '" + transitName + "';";

					//rs = statement.executeQuery(query);
					//rs.next();
					query = "SELECT seatNumber FROM TrainRDBMS.seat WHERE NOT EXISTS (SELECT seatNumber FROM TrainRDBMS.reservation, TrainRDBMS.schedule WHERE schedule.scheduleid = reservation.scheduleid AND schedule.tid = reservation.tid AND seatNumber = seat.seatNumber AND reservation.scheduleid = " + scheduleid + ") AND seat.tid = " + tid + " AND seat.class = " + seatClass + ";";

    

					rs = statement.executeQuery(query);
					if(rs.next())
					{
						seatNumber = rs.getInt(1);
						out.print("Seat number = " + seatNumber + "<br>");
					}
    				if(request.getParameterValues("customerRep")!=null)
    				{
    					query = "SELECT ssn FROM TrainRDBMS.employee ORDER BY RAND() LIMIT 1;";
    					rs = statement.executeQuery(query);
    					rs.next();
    					customerRepSSN = rs.getString(1);
    					
    				}

					
					out.print("Reservation id : " + rid + "<br/>");
					out.print("Transit Name : " + transitName + "<br/>");
					out.print("Origin : " + desiredOrigin + "<br/>");
					out.print("Destination : " + desiredDestination + "<br/>");
					out.print("Total fee : $" + travelFee + "<br/>");
					out.print("Booking fee : $" + bookingFee + "<br>");
					out.print(seatClass + " cost : $" + classCost + "<br>");
					out.print("Reservation date is : " + new java.util.Date().toString() + "<br/>");
					out.print("Seat number : " + seatNumber + "<br/>");
					

					//SimpleDateFormat format = new SimpleDateFormat("YYYY-MM-DD");
					//String reservationDate = new java.util.Date().toString();
					//DateFormat formatter = new SimpleDateFormat("YYYY-MM-dd");
					//out.print(formatter.format(new java.util.Date()) + "<br/>");
					java.util.Date javaRD = new java.util.Date();
					java.sql.Date reservationDateSql = new java.sql.Date(javaRD.getTime());
					//out.print("Reservation Date SQL : " + reservationDateSql + "<br>");
					query = "INSERT INTO TrainRDBMS.reservation (rid, username, transitName, scheduleid, tid, originSid, destinationSid, bookingFee, totalFare, bookingDate, pastReservation, seatNumber, class) VALUES ( " + rid + ", '" + username + "', '" + transitName + "', " + scheduleid + ", " + tid + ", " + desiredOrigin + ", " + desiredDestination + ", " + bookingFee + ", " + travelFee + ", '" + reservationDateSql + "', FALSE, " + seatNumber + ", " + seatClass + " );";
					result = statement.executeUpdate(query);
					if(!customerRepSSN.equals(""))
					{
						query = "Select first, last FROM TrainRDBMS.employee WHERE ssn = '" + customerRepSSN + "';";
						rs = statement.executeQuery(query);
						rs.next();
						String repName = rs.getString(1) + " " + rs.getString(2);
						out.print("Your customer Rep is : " + repName + "<br>");
						query = "UPDATE TrainRDBMS.reservation SET ssn = '" + customerRepSSN + "' WHERE username = '" + username + "' AND rid = " + rid + ";";
						result = statement.executeUpdate(query);
					}
					session.removeAttribute("transitName");
					session.removeAttribute("tid");
					con.close();
				}catch(Exception e)
					{
						//out.print(e);
					}
			%>
			<form method = "get" action = "retrieveSchedules.jsp">
			<input type = "submit" value = "Go back to Schedules"/>
			</form>
			
			<form method = "get" action = "viewReservations.jsp">
			<input type = "submit" value = "View Your Reservations"/>
			</form>
		</body>

</html>