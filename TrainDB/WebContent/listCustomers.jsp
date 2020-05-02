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
<%
Connection con = null;
ResultSet resultSet = null;
%>

<h2>List of Customers on the given train and transit line</h2>
<br>

<table>
<tr>
<th>Username</th>
<th>First Name</th>
<th>Last Name</th>
<th>Email</th>
<th>Phone #</th>
<th>City</th>
<th>State</th>
<th>Zip</th>
</tr>
<%
	try{
		ApplicationDB db = new ApplicationDB();
		con = db.getConnection();
	//recieve relevant info
		String transitName = request.getParameter("transitName").toString();
		String scheduleid = request.getParameter("scheduleid").toString();
		String tid = request.getParameter("tid").toString();
	
		PreparedStatement st1 = con.prepareStatement("SELECT DISTINCT customers.username, customers.first, customers.last, customers.email, customers.phone, customers.city, customers.state, customers.zip FROM customers, reservation WHERE customers.username = reservation.username AND reservation.transitName =? AND reservation.tid =? AND reservation.scheduleid = ?;");
		st1.setString(1, transitName);
		st1.setInt(2, Integer.parseInt(scheduleid));
		st1.setInt(3, Integer.parseInt(tid));
		ResultSet tr = st1.executeQuery();
		while(tr.next())
		{
			%>
				<tr>
				<td><%=resultSet.getString("username") %></td>
				<td><%=resultSet.getString("first") %></td>
				<td><%=resultSet.getString("last") %></td>
				<td><%=resultSet.getString("email") %></td>
				<td><%=resultSet.getString("phone") %></td>
				<td><%=resultSet.getString("city") %></td>
				<td><%=resultSet.getString("state") %></td>
				<td><%=resultSet.getString("zip") %></td>
				</tr>
			<% 
		}
		con.close();
	}
catch(Exception e){
	out.print(e);
	out.print("\n Error getting data.");
}

%>
</table>


<form method="get" action = "employeePage.jsp">
		<input type="submit" value="Return Home">
</form>


</body>
</html>