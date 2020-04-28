<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.traindb.pk.*" %>
<%@ page import ="java.util.ArrayList"%>
<%@page import="java.util.Map" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="javax.servlet.http.HttpServletResponse"%>
<%@ page isELIgnored="false" %>
<%@page import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Schedule Search</title>
</head>
<body>
<br>

	<%!
	public class TrainData {
		String startStation;
		String stopStation;
		String startDate;
		String endDate;
		double monthly;
		double weekly;
		double single;
		double round;
		ArrayList<String> stops;
		
		public TrainData(String startStation, String stopStation, String startDate, String endDate, double monthly,
				double weekly, double single, ArrayList<String> stops) {
			this.startStation = startStation;
			this.stopStation = stopStation;
			this.startDate = startDate;
			this.endDate = endDate;
			this.monthly = monthly;
			this.weekly = weekly;
			this.single = single;
			this.round = 2*this.single;
			this.stops = stops;
		}
		
		public String toString() {
			String str = "Start: " + startStation + ", End: " + stopStation + ", departure: " + startDate + ", arrival: " + endDate + 
					", monthly: " + monthly + ", weekly: " + weekly + ", single: " + single + ", round: " + round + ", stops: " + stops;
			return str;
		}
	}
	%>
	
		
	<%!
		public void drawTable(ArrayList<TrainData> schedule, JspWriter myout) {
		try {
		//make table of data
		myout.print("<table border=\"1\">");

		//make the column row
		myout.print("<tr>");
		
		//start station
		myout.print("<td>");
		myout.print("Departure Station");
		myout.print("</td>");
		
		//end station
		myout.print("<td>");
		myout.print("Arrival Station");
		myout.print("</td>");
		
		//departure time
		myout.print("<td>");
		myout.print("Departure Time");
		myout.print("</td>");
		
		//arrival time
		myout.print("<td>");
		myout.print("Arrival Time");
		myout.print("</td>");
		
		//monthly cost
		myout.print("<td>");
		myout.print("Monthly");
		myout.print("</td>");
		
		//weekly cost
		myout.print("<td>");
		myout.print("Weekly");
		myout.print("</td>");
		
		//single trip cost
		myout.print("<td>");
		myout.print("One-Way");
		myout.print("</td>");
		
		//round trip cost
		myout.print("<td>");
		myout.print("Round");
		myout.print("</td>");
		
		//stops list
		myout.print("<td>");
		myout.print("Stops");
		myout.print("</td>");
		
		//close column row
		myout.print("</tr>");

		
		String startStation;
		String stopStation;
		String startDate;
		String endDate;
		double monthly;
		double weekly;
		double single;
		double round;
		ArrayList<String> stops;
		for (TrainData td : schedule) {
			//make the data row
			myout.print("<tr>");
			
			//start station
			myout.print("<td>");
			myout.print(td.startStation);
			myout.print("</td>");
			
			//end station
			myout.print("<td>");
			myout.print(td.stopStation);
			myout.print("</td>");
			
			//departure time
			myout.print("<td>");
			myout.print(td.startDate);
			myout.print("</td>");
			
			//arrival time
			myout.print("<td>");
			myout.print(td.endDate);
			myout.print("</td>");
			
			//monthly cost
			myout.print("<td>");
			myout.print("$" + td.monthly);
			myout.print("</td>");
			
			//weekly cost
			myout.print("<td>");
			myout.print("$" + td.weekly);
			myout.print("</td>");
			
			//single trip cost
			myout.print("<td>");
			myout.print("$" + td.single);
			myout.print("</td>");
			
			//round trip cost
			myout.print("<td>");
			myout.print("$" + td.round);
			myout.print("</td>");
			
			//stops list
			myout.print("<td>");
			myout.print(td.stops.size() == 0 ? "Direct, no stops" : td.stops);
			myout.print("</td>");
			
			//close data row
			myout.print("</tr>");
		}
		
		//close table of data
		myout.print("</table>");
		} catch (Exception e) {
			System.out.println(e);
		}
		}
	%>

	<%
	try {
	
	String start = request.getParameter("start");
	String end = request.getParameter("end");
	String transit = session.getAttribute("transit").toString();
	String startDate = request.getParameter("from");
	if (startDate == "" || startDate == null)
		startDate = "2000-01-01";
	String endDate = request.getParameter("to");
	if (endDate == "" || endDate == null)
		endDate = "2100-01-01";
	ArrayList<TrainData> schedule_info = new ArrayList<TrainData>();
	
	//Get the database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();	
	
	//get all stops associated with the transit name
	PreparedStatement st = con.prepareStatement(
			"select st.name 'startStation', st2.name 'stopStation'" +
			"from stops s join station st on s.startSid = st.sid join station st2 on s.stopSid = st2.sid " +
			"join schedule sc on s.transitName = sc.transitName and s.scheduleid = sc.scheduleid " +
			"where s.transitName = ? order by s.departureTime, s.scheduleid");
	st.setString(1, transit);
	ResultSet rs = st.executeQuery();
	
	//list of stops for this transit lines
	ArrayList<String> stops = new ArrayList<String>();
	
	//add the stops to the stops arraylist
	while (rs.next()) {
		String startStation = rs.getString("startStation");
		String stopStation = rs.getString("stopStation");
		if (!stops.contains(startStation))
			stops.add(startStation);
		if (!stops.contains(stopStation))
			stops.add(stopStation);
	}
	
	//make sure order of train stops are in sequential order i.e. origin comes before destination
	if (stops.indexOf(start) > stops.indexOf(end))
		Collections.reverse(stops);
	
	int i = 0;
	while (true) {
		i++;
		st = con.prepareStatement(
				"select s.transitName, st.name 'startStation', st2.name 'stopStation', s.departureTime, s.arrivalTime, " +
				"s.monthly, s.weekly, s.singleTrip, sc.tid, sc.scheduleid " +
				"from stops s join station st on s.startSid = st.sid join station st2 on s.stopSid = st2.sid " +
				"join schedule sc on s.transitName = sc.transitName and s.scheduleid = sc.scheduleid " +
				"where s.transitName = ? and s.scheduleid=? and s.departureTime between ? and ? order by s.departureTime");
		st.setString(1, transit);
		st.setString(2, Integer.toString(i));
		st.setString(3, startDate);
		st.setString(4, endDate);
		rs = st.executeQuery();

		int s = 0;
		int e = 0;
		String s_date = "";
		String e_date = "";
		double monthly = 0, weekly = 0, single = 0;
		int j = 0;
		ArrayList<String> stops_on_way = new ArrayList<String>();
		boolean s_updated = false;
		boolean e_updated = false;
		
		if (!rs.next())
			break;
		
		rs.beforeFirst();
		
		while (rs.next()) {
			//System.out.println("Start: " + rs.getString("startStation") + ", End: " + rs.getString("stopStation"));
			
			j++;
			if (start.equals(rs.getString("startStation"))) {
				s = j;
				s_date = rs.getString("departureTime");
				s_updated = true;
			}
			
			if (s_updated == true) {
				//System.out.println("Start: " + rs.getString("startStation") + ", End: " + rs.getString("stopStation"));
				//System.out.println("monthly: " + monthly + ", weekly: " + weekly + "Single: " + single);
				monthly = Double.parseDouble(rs.getString("monthly")) + monthly;
				weekly = Double.parseDouble(rs.getString("weekly")) + weekly;
				single = Double.parseDouble(rs.getString("singleTrip")) + single;
				if (!end.equals(rs.getString("stopStation")) && !stops_on_way.contains(rs.getString("stopStation"))) {
					stops_on_way.add(rs.getString("stopStation"));
				}
			}
			
			if (end.equals(rs.getString("stopStation"))) {
				if (s_updated == true) {
					e = j;
					e_date = rs.getString("arrivalTime");
					e_updated = true;
				}
				break;
			}
			
		}
		
		if (e >= s && e_updated && s_updated) {
			TrainData td = new TrainData(start, end, s_date, e_date, monthly, weekly, single, stops_on_way);
			schedule_info.add(td);
		}
		
		
	}
	
	drawTable(schedule_info, out);
	
	%>
	<br>
	<br>
	<form method="post" action="search.jsp">
	<input type="submit" value="Back">
	</form>
	
	<%
	//close the connection.
	db.closeConnection(con);
	} catch (Exception e) {
		out.print(e);
	}
	
	%>
	

</body>

</html>