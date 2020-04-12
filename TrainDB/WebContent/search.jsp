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
<br>

	<%
	try {
		
	
	ArrayList<String> transit_lines = new ArrayList<String>();
	HashMap<String, ArrayList<String>> lines_with_stops = new HashMap<String, ArrayList<String>>(); 
	String transit = request.getParameter("transit");
	
	//Get the database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();	
	
	//get all transit names
	PreparedStatement st = con.prepareStatement("SELECT distinct transitName FROM schedule order by transitName");
	ResultSet rs = st.executeQuery();
	
	while (rs.next()) {
		transit_lines.add(rs.getString("transitName"));
	}
	
	for (int i = 0; i < transit_lines.size(); i++) {
		//get all stops associated with the transit name
		st = con.prepareStatement(
				"select st.name 'startStation', st2.name 'stopStation'" +
				"from stops s join station st on s.startSid = st.sid join station st2 on s.stopSid = st2.sid " +
				"join schedule sc on s.transitName = sc.transitName and s.scheduleid = sc.scheduleid " + 
				"where s.transitName = ? order by s.departureTime, s.scheduleid");
		st.setString(1, transit_lines.get(i));
		rs = st.executeQuery();
		
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
		
		//insert this information into the hashmap
		lines_with_stops.put(transit_lines.get(i), stops);
	}
	
	%>
		Transit Line: 
		<form name="transit" method="post">
		<select id="transit" name="transit">
		<%
		for (String trans : lines_with_stops.keySet()) {
		if (trans.equals(transit)) {
		%>
		<option value="<%=trans%>" selected="selected">
				<%=trans%>
		</option>
		<%
		} else {
		%>
		<option value="<%=trans%>">
				<%=trans%>
		</option>
		<%
		}
		%>
			
		<%
		}
		%>
		</select>
		<input type="submit" name="submit" value="Select Transit"/>
		</form>
		
		<br>
	
	
	
	<% 
	if (transit != null) {
	%>
		<form id="search" name="search" method="post" action="searchView.jsp">
		Origin Station: 
			<select id="start" name="start">
			<%
			for (String start : lines_with_stops.get(transit)) {
			%>
				<option value="<%=start%>">
				<%=start%>
				</option>
			<%
			}
			%>
			</select>
			
			<br>
			
			Destination Station: 
			<select id="end" name="end">
			<%
			for (String end : lines_with_stops.get(transit)) {
			%>
				
				<option value="<%=end%>">
				<%=end%>
				</option>
			<%
			}
			%>
			</select>
			
			<br>
			<br>
			
		  <label>From: </label>
		  <input type="date" id="from" name="from">
			
			<br>
			<br>
			
		  <label>To: </label>
		  <input type="date" id="to" name="to">
		  
		  <br>
		  <br>
			
		<%session.setAttribute("transit", transit);%>
		<input type="submit" name="submit" value="Search Schedule">
		</form>
	<%
	}	
	%>	
	
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
	

<br>

</body>

</html>