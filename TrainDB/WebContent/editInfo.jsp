<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.traindb.pk.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit User Info</title>
</head>
<body>
<%
	    
		try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Get the username and password from html text boxes
			String username = request.getParameter("username");
			// ---------------------------UPDATE 4/21-------------------------------
			
			PreparedStatement st = con.prepareStatement("SELECT * FROM customers WHERE username = ?");
			st.setString(1, username);
			ResultSet rs = st.executeQuery();

			if (rs.next()) {
				
					session.setAttribute("username", username);
					session.setAttribute("email", rs.getString("email"));
					session.setAttribute("first", rs.getString("first"));
					session.setAttribute("last", rs.getString("last"));
					session.setAttribute("phone", rs.getString("phone"));
					session.setAttribute("city", rs.getString("city"));
					session.setAttribute("state", rs.getString("state"));
					session.setAttribute("zip", rs.getString("zip"));
					

			} else {
				//no result set from username means the user doesn't exist
				out.print("There is no account associated with that username");
				db.closeConnection(con);
				return;
			}
			//close the connection.
			db.closeConnection(con);
		} catch (Exception e) {
			out.print(e);
		}
	%>

	<form method="post" action="editInfoFeedback.jsp">
	<b>Email </b>
	<input type="email" name="email" value = <%=session.getAttribute("email")%>>
	<br>
	<br>
	<b>First Name </b>
	<input type="text" name="first" value = <%=session.getAttribute("first")%>>
	<br>
	<br>
	<b>Last Name </b>
	<input type="text" name="last" value = <%=session.getAttribute("last")%>>
	<br>
	<br>
	<b>Phone Number </b>
	<input type="tel" name="phone" pattern="[0-9]{3}-[0-9]{3}-[0-9]{4}" value = <%=session.getAttribute("phone")%>>
	Format: 123-456-7890
	<br>
	<br>
	<b>City </b>
	<input type="text" name="city" value = <%=session.getAttribute("city")%>>
	<br>
	<br>
	<b>State </b>
	<input type="text" name="state"value = <%=session.getAttribute("state")%>>
	<br>
	<br>
	<b>Zip </b>
	<input type="text" name="zip" pattern="[0-9]{5}"value = <%=session.getAttribute("zip")%>>
	Format: 12345 (5 digits)
	<br>
	<br>
	
	<input type="submit" value="Done Editing">
	</form>
<br>

</body>
</html>