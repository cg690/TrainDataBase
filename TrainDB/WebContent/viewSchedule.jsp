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
		
		public TrainData(String transit, String startStation, String stopStation, String startDate, String endDate, double monthly,
				double weekly, double single) {
			this.transit = transit;
			this.startStation = startStation;
			this.stopStation = stopStation;
			this.startDate = startDate;
			this.endDate = endDate;
			this.monthly = monthly;
			this.weekly = weekly;
			this.single = single;
			this.round = 2*this.single;
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
	List<String> orderList = Arrays.asList("Transit Name", "Departure Station", "Arrival Station", "Departure Time", "Arrival Time", "Monthly", "Weekly", "Single Trip", "Round Trip");
	ArrayList<TrainData> schedule_info = new ArrayList<TrainData>();
	
	//Get the database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();	
	
	//System.out.println(i);
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
	
	sql_cmd += ord;
	
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
		TrainData td = new TrainData(transit, start, end, s_date, e_date, monthly, weekly, single);
		schedule_info.add(td);
	}

	drawTable(schedule_info, out);
	%>
	
	Sort By: 
	<form name="sort" method="post">
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