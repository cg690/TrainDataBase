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
<title>View Schedule</title>
</head>
<body>
<br>

	<%!
	public class TrainData {
		String transit;
		String startStation;
		String stopStation;
		String startDate;
		String endDate;
		double monthly;
		double weekly;
		double single;
		double round;
		int scheduleid;
		int train;
		
		public TrainData(String transit, String startStation, String stopStation, String startDate, String endDate, double monthly,
				double weekly, double single, int scheduleid, int train) {
			this.transit = transit;
			this.startStation = startStation;
			this.stopStation = stopStation;
			this.startDate = startDate;
			this.endDate = endDate;
			this.monthly = monthly;
			this.weekly = weekly;
			this.single = single;
			this.round = 2*this.single;
			this.scheduleid = scheduleid;
			this.train = train;
		}
		
		public String toString() {
			String str = "Start: " + startStation + ", End: " + stopStation + ", departure: " + startDate + ", arrival: " + endDate + 
					", monthly: " + monthly + ", weekly: " + weekly + ", single: " + single + ", round: " + round;
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

		//transit name 
		myout.print("<td>");
		myout.print("Transit Name");
		myout.print("</td>");
		
		//schedule id 
		myout.print("<td>");
		myout.print("Schedule ID");
		myout.print("</td>");
		
		//train number 
		myout.print("<td>");
		myout.print("Train Number");
		myout.print("</td>");
		
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
			
			//transit name 
			myout.print("<td>");
			myout.print(td.transit);
			myout.print("</td>");
			
			//schedule id 
			myout.print("<td>");
			myout.print(td.scheduleid);
			myout.print("</td>");
			
			//train number 
			myout.print("<td>");
			myout.print(td.train);
			myout.print("</td>");
			
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
	String sort_order = request.getParameter("sort");
	String search_origin = request.getParameter("origin");
	String search_destination = request.getParameter("destination");
	if (search_origin != null && search_origin.equals("Any")) {
		search_origin = "";
	}
	if (search_destination != null && search_destination.equals("Any")) {
		search_destination = "";
	}

	List<String> orderList = Arrays.asList("Transit Name", "Departure Station", "Arrival Station", "Departure Time", "Arrival Time", "Monthly", "Weekly", "Single Trip", "Round Trip");
	ArrayList<TrainData> schedule_info = new ArrayList<TrainData>();
	
	ArrayList<String> stations = new ArrayList<String>();
	stations.add("Any");
	
	//Get the database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();	
	
	//fill in all stations
	PreparedStatement ps = con.prepareStatement("select distinct name from station order by name");
	ResultSet res = ps.executeQuery();
	while (res.next()) {
		stations.add(res.getString("name"));
	}
	
	
	String sql_cmd = "select s.transitName, st.name 'startStation', st2.name 'stopStation', s.departureTime, s.arrivalTime, " +
			"s.monthly, s.weekly, s.singleTrip, sc.tid, sc.scheduleid " +
			"from stops s join station st on s.startSid = st.sid join station st2 on s.stopSid = st2.sid " +
			"join schedule sc on s.transitName = sc.transitName and s.scheduleid = sc.scheduleid ";
	
	String ord = "";
	if (sort_order == null || sort_order.equals("")) {
		ord = "order by s.transitName, s.departureTime, sc.scheduleid";
	} else if (sort_order.equals("Transit Name")) {
		ord = "order by s.transitName, s.departureTime, sc.scheduleid";
	} else if (sort_order.equals("Departure Station")) {
		ord = "order by startStation, s.departureTime, sc.scheduleid";
	} else if (sort_order.equals("Arrival Station")) {
		ord = "order by stopStation, s.departureTime, sc.scheduleid";
	} else if (sort_order.equals("Departure Time")) {
		ord = "order by s.departureTime, sc.scheduleid";
	} else if (sort_order.equals("Arrival Time")) {
		ord = "order by s.arrivalTime, sc.scheduleid";
	} else if (sort_order.equals("Monthly")) {
		ord = "order by s.monthly, sc.scheduleid";
	} else if (sort_order.equals("Weekly")) {
		ord = "order by s.weekly, sc.scheduleid";
	} else if (sort_order.equals("Single Trip")) {
		ord = "order by s.singleTrip, sc.scheduleid";
	} else if (sort_order.equals("Round Trip")) {
		ord = "order by s.singleTrip, sc.scheduleid";
	}
	
	String sql_station = "";
	if ((search_origin == null || search_origin.equals("")) && (search_destination == null || search_destination.equals(""))) {
		//do nothing
	} else if ((search_origin == null || search_origin.equals(""))) {
		sql_station = "where st2.name=\"" + search_destination + "\" ";
	} else {
		sql_station = "where st.name=\"" + search_origin + "\" ";
	}
	
	sql_cmd = sql_cmd + sql_station + ord;
	
	PreparedStatement st = con.prepareStatement(sql_cmd);
	//st.setString(1, transit);
	ResultSet rs = st.executeQuery();
	
	while (rs.next()) {
		String transit = rs.getString("transitName");
		String start = rs.getString("startStation");
		String end = rs.getString("stopStation");
		String s_date = rs.getString("departureTime");
		String e_date = rs.getString("arrivalTime");
		double monthly = Double.parseDouble(rs.getString("monthly"));
		double weekly = Double.parseDouble(rs.getString("weekly"));
		double single = Double.parseDouble(rs.getString("singleTrip"));
		int scheduleid = Integer.parseInt(rs.getString("sc.scheduleid"));
		int train = Integer.parseInt(rs.getString("sc.tid"));
		TrainData td = new TrainData(transit, start, end, s_date, e_date, monthly, weekly, single, scheduleid, train);
		schedule_info.add(td);
	}

	drawTable(schedule_info, out);
	%>
	
	<br>
	
	<form name="sort" method="post">
	Sort By: 
	<select id=sort name="sort">
		<%
		for (String order : orderList) {
		if (order.equals(sort_order)) {
		%>
		<option value="<%=order%>" selected="selected">
				<%=order%>
		</option>
		<%
		} else {
		%>
		<option value="<%=order%>">
				<%=order%>
		</option>
		<%
		}
		%>
			
		<%
		}
		%>
	</select>
	<input type="submit" name="submit" value="Sort Schedule"/>
	</form>
	
	<br>
	
	<form name="origin" method="post">
	Filter By Departure Station:  
	<select id=origin name="origin">
		<%
		for (String origin : stations) {
		if (origin.equals(search_origin)) {
		%>
		<option value="<%=origin%>" selected="selected">
				<%=origin%>
		</option>
		<%
		} else {
		%>
		<option value="<%=origin%>">
				<%=origin%>
		</option>
		<%
		}
		%>
			
		<%
		}
		%>
	</select>
	<input type="submit" name="submit" value="Filter"/>
	</form>

	<br>
	<form name="destination" method="post">
	Filter By Arrival Station:  
	<select id=destination name="destination">
		<%
		for (String dest : stations) {
		if (dest.equals(search_destination)) {
		%>
		<option value="<%=dest%>" selected="selected">
				<%=dest%>
		</option>
		<%
		} else {
		%>
		<option value="<%=dest%>">
				<%=dest%>
		</option>
		<%
		}
		%>
			
		<%
		}
		%>
	</select>
	<input type="submit" name="submit" value="Filter"/>
	</form>
	
	<br>
	<br>
	<form method="post" action="home.jsp">
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