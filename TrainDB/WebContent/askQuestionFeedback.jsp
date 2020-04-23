<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.traindb.pk.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>NJ Transit</title>
</head>
<body>
<p>Question Confirmation</p>
<br>
<br>
<%
	try{
		ApplicationDB app = new ApplicationDB();
		Connection con = app.getConnection();
		
		//recieve the username from the session
		String username = session.getAttribute("username") == null ? "" : session.getAttribute("username").toString();
		String question = request.getParameter("question").equals("") ? null : request.getParameter("question");
		int question_id = (int) (Math.random() * 10000);
		
		if(question==null){
			out.println("Please enter a question");
		}else{
			//now we can insert into the database
			PreparedStatement pmst = con.prepareStatement("INSERT INTO questions(username, question, question_id) VALUES (?,?,?)");
			try{
				pmst.setString(1,username);
				pmst.setString(2,question);
				pmst.setInt(3, question_id);
				pmst.execute();
				
				out.print("Question has been asked. Check back to your Customer Service page for a response at a later time.");
			}catch (Exception e) {
				out.print("There was an error");
			}
		}
		
		
		app.closeConnection(con);
	}catch (Exception e) {
		
		
		out.print(e);
	}
%>
<br>
<br>

<form method="get" action = "messageCustomerService.jsp">
		<input type="submit" value="Return to Customer Service">
</form>

</body>
</html>