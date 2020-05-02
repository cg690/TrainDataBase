<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.traindb.pk.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Answer Question</title>
</head>
<body>
<p>Reply to the question</p>
<br>
<br>
<%
	try{
		ApplicationDB app = new ApplicationDB();
		Connection con = app.getConnection();
		

		//recieve relevant info
		String question_id = request.getParameter("question_id").toString();
		String answer = request.getParameter("ans");
		String ssn = session.getAttribute("ssn").toString();
		
		out.println(question_id);
		out.println(answer);
		out.println(ssn);
		
		PreparedStatement st = con.prepareStatement("SELECT username from questions WHERE question_id=?;");
		st.setString(1,question_id);
		ResultSet tr = st.executeQuery();
		
		String customer_username="";
		
		if(tr.next())
			customer_username = tr.getString("username");

		out.print(customer_username);
		if(answer==null){
			out.println("Please answer the question");
		}else{
			try{
				//now we can insert into the database
				PreparedStatement pmst = con.prepareStatement("INSERT INTO answers(ssn_rep, answer, customer_username, question_id) VALUES (?,?,?,?);");
				pmst.setString(1,ssn);
				pmst.setString(2,answer);
				pmst.setString(3,customer_username);
				pmst.setInt(4, Integer.parseInt(question_id));
				pmst.execute();
				
				out.print("The Question has been answered and tables have been updated!");
			}catch (Exception e) {
				out.print(e);
				out.print("There was an error, try again");
			}
		}
		
		
		app.closeConnection(con);
	}catch (Exception e) {
		
		
		out.print(e);
	}
%>
<br>
<br>

<form method="get" action = "employeePage.jsp">
		<input type="submit" value="Return Home">
</form>

</body>
</html>