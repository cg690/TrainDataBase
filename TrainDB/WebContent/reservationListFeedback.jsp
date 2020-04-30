<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.traindb.pk.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>reservation list</title>
</head>
<body>

<table aligh="center" cellpadding="5" cellspacing="5" border="1">

<tr>
</tr>
<tr>
<td><b>Reservation id</b>

	<%
	    
		try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Get the username and password from html text boxes
			// ---------------------------UPDATE 4/21-------------------------------
			
			if(request.getParameter("tlist")!=null){
				String tname = request.getParameter("tname");
				String tid = request.getParameter("tid");
				
				PreparedStatement st = con.prepareStatement("SELECT * FROM schedule WHERE transitName = ?");
				st.setString(1, tname);
				ResultSet rs = st.executeQuery();
				
				if(rs.next()){
					
					PreparedStatement st2 = con.prepareStatement("SELECT * FROM train WHERE tid = ?");
					st2.setString(1, tid);
					ResultSet rs2 = st2.executeQuery();
					if(rs2.next()){
						PreparedStatement st3 = con.prepareStatement("SELECT r.rid FROM reservation r, schedule s WHERE r.transitName = s.transitName AND s.tid = ? AND s.transitName = ?");
						st3.setString(1,tid);
						st3.setString(2, tname);
						
						ResultSet rs3 = st3.executeQuery();
					while(rs3.next()){
%>
<tr>

<td> <%=rs3.getString("rid") %> </td>

</tr>

						

<%				 
					}
						
					}
					else{
						out.print("There is no train ID with that number");
						db.closeConnection(con);
						return;
					}
					
					
					
				}
				else{
					out.print("There is no transit line with that name");
					db.closeConnection(con);
					return;
				}
				
				
			}
			else{
				
				String username = request.getParameter("username");
				
				PreparedStatement st = con.prepareStatement("SELECT * FROM customers WHERE username = ?");
				st.setString(1, username);
				ResultSet rs = st.executeQuery();
				
				if(rs.next()){
					

					
					PreparedStatement st2 = con.prepareStatement("SELECT rid FROM reservation WHERE username = ?");
					st2.setString(1, username);
					ResultSet rs2 = st2.executeQuery();
					
					while(rs2.next()){
						
						
						
%>
<tr>

<td> <%=rs2.getString("rid") %> </td>

</tr>

						

<%				
					}
						
						
						
					
					
				}
				else{
					out.print("USER DOES NOT EXIST");
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
</body>
</html>
