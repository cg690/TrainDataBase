<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.traindb.pk.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Best customer and lines</title>
</head>
<body>
<%
	    
		try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			
			PreparedStatement st = con.prepareStatement("SELECT username, MAX(sum) AS max FROM (SELECT r.username, sum(bookingFee) as sum FROM reservation r GROUP BY r.username) AS t");
			ResultSet rs = st.executeQuery();
			out.print("<b>Best customer:</b><br>");
			
			while(rs.next()){
				out.print(rs.getString("username")+": $"+rs.getString("max"));

				out.print("<br>");
			}
			out.print("<b>Most active train lines:</b><br>");
			PreparedStatement st2 = con.prepareStatement("SELECT transitName,count(*) as count FROM reservation GROUP BY transitName ORDER BY count DESC LIMIT 5");
			ResultSet rs2 = st2.executeQuery();
			while(rs2.next()){
			out.print(rs2.getString("transitName")+": "+rs2.getString("count")+" Reservations");

			out.print("<br>");
			}
			

			
			//close the connection.
			db.closeConnection(con);
		} catch (Exception e) {
			out.print(e);
		}
	%>
<br>

</body>
</html>
