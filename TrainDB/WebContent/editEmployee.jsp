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
			String ssn = request.getParameter("ssn");
			
			if(request.getParameter("editButton")!=null){
			
			PreparedStatement st = con.prepareStatement("SELECT * FROM employee WHERE ssn = ?");
			st.setString(1, ssn);
			ResultSet rs = st.executeQuery();

			if (rs.next()) {
				
				session.setAttribute("op", "edit");
				session.setAttribute("first", rs.getString("first"));
				session.setAttribute("last", rs.getString("last"));
				session.setAttribute("ssn", ssn);
				
				out.print("Edit for employee: "+ssn);
					
					

			} else {
				//no result set from username means the user doesn't exist
				out.print("There is no employee associated with that ssn");
				db.closeConnection(con);
				return;
			}
			}
			
			else if(request.getParameter("addButton")!=null){
				
				PreparedStatement st = con.prepareStatement("SELECT * FROM employee WHERE ssn = ?");
				st.setString(1, ssn);
				ResultSet rs = st.executeQuery();
				
				if (rs.next()) {
					out.print("EMPLOYEE WITH THAT SSN ALREADY EXISTS");
					db.closeConnection(con);
					return;

				} else {
					out.print("Adding employee: "+ssn);
					session.setAttribute("op","add");
					session.setAttribute("ssn", ssn);

					session.setAttribute("first", "");
					session.setAttribute("last", "");
				}
				
			}
			else if(request.getParameter("deleteButton")!=null){
				
				//no error, create the account
								
				PreparedStatement st = con.prepareStatement("SELECT * FROM employee WHERE ssn = ?");
				st.setString(1, ssn);
				ResultSet rs = st.executeQuery();
				
				try {
					if(rs.next()){
					
					PreparedStatement pmst1 = con.prepareStatement("DELETE FROM employee WHERE ssn=?");
					pmst1.setString(1, ssn);
					pmst1.execute();
					
					out.print("Successfully Deleted employee");

					db.closeConnection(con);
					return;
					}
					else{
						out.print("Employee with that ssn does not exist");

						//close the connection.
						db.closeConnection(con);
						return;
					}
					
				} catch (Exception e) {
					out.print("Employee with that ssn does not exist");

					//close the connection.
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
	<br>
	<form method="post" action="editEmployeeFeedback.jsp">
	<br>
	<b>First Name </b>
	<input type="text" name="first" value = <%=session.getAttribute("first")%>>
	<br>
	<br>
	<b>Last Name </b>
	<input type="text" name="last" value = <%=session.getAttribute("last")%>>
	<br>
	
	<input type="submit" value="Done">
	</form>
<br>

</body>
</html>