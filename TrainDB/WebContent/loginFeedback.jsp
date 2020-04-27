<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.traindb.pk.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Train Login</title>
</head>
<body>
	<%
	    
		try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Get the username and password from html text boxes
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			
						
			if(username.equalsIgnoreCase("admin")){
				
				if(password.equals("admin")){

					response.sendRedirect("adminUI.jsp");
					return;
					
					
				}else{
					out.print("Wrong password for Admin login");
				}
				
			}
			else{
			
			PreparedStatement st = con.prepareStatement("SELECT * FROM customers WHERE username = ?");
			st.setString(1, username);
			ResultSet rs = st.executeQuery();

			if (rs.next()) {
				if (rs.getString("password").equals(password)) {
					session.setAttribute("username", username);
					session.setAttribute("password", password);
					session.setAttribute("email", rs.getString("email"));
					session.setAttribute("first", rs.getString("first"));
					session.setAttribute("last", rs.getString("last"));
					session.setAttribute("phone", rs.getString("phone"));
					session.setAttribute("city", rs.getString("city"));
					session.setAttribute("state", rs.getString("state"));
					session.setAttribute("zip", rs.getString("zip"));
					
		            response.sendRedirect("home.jsp");
		            return;
				} else {
					out.print("You entered the wrong password");
				}
			} else {
				//check if the user is an employee! 
				st = con.prepareStatement("SELECT * FROM employee WHERE username = ?");
				st.setString(1,username);
				rs = st.executeQuery();
				
				if(rs.next()){
					if(rs.getString("password").equals(password)){
						session.setAttribute("ssn",rs.getString("ssn"));
						session.setAttribute("username",username);
						session.setAttribute("password",password);
						session.setAttribute("first", rs.getString("first"));
						session.setAttribute("last", rs.getString("last"));
						
						response.sendRedirect("employeePage.jsp");
						return;
					} else {
						out.print("The password entered is incorrect :(");
					}
				}
				
				out.print("There is no account associated with that username");
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
