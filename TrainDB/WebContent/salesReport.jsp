<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.traindb.pk.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sales Report</title>
</head>
<body>
	<%
	    
		try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Get the username and password from html text boxes
			String month = request.getParameter("month");
			String year = request.getParameter("year");
			
			if(Integer.parseInt(month)>12||Integer.parseInt(month)<1){
				
				out.print("ENTER A VALID MONTH");
				return;
			}
			
			// ---------------------------UPDATE 4/21-------------------------------

			PreparedStatement st = con.prepareStatement("SELECT SUM(bookingFee) AS sum FROM reservation WHERE MONTH(bookingDate) = ? AND YEAR(bookingDate) = ?");
			st.setString(1, month);
			st.setString(2, year);
			ResultSet rs = st.executeQuery();

			if (rs.next()) {
				
				System.out.print(rs.getString("sum"));
			} else {
				//no result set from username means the user doesn't exist
				out.print("NO SALES");
			}
			


			//close the connection.
			db.closeConnection(con);
		} catch (Exception e) {
			out.print(e);
		}
	%>
</body>
</html>