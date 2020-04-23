<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.traindb.pk.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>NJTransit</title>


</head>
<body>
<h1>Welcome to Customer Service!</h1>

<form method="get" action = "home.jsp">
		<input type="submit" value="Return Home">
</form>
<br>
<br>
<form method="get" action = "askQuestion.jsp">
		<input type="submit" value="Message Customer Service">
</form>

	<br>
	<br>
	
	<form method="get" action = "searchQuestions.jsp">
	<input type="submit" value="Search Questions and Answers">
</form>
<br>
<br>





	
<%
try{
	ApplicationDB app = new ApplicationDB();
	Connection con = app.getConnection();
	String username = session.getAttribute("username") == null ? "" : session.getAttribute("username").toString();
	StringBuilder sb = new StringBuilder();
	sb.append('\'');
	sb.append(username);
	sb.append('\'');
	String finalUserName = sb.toString();
	String query = "SELECT * FROM questions WHERE questions.username=" + finalUserName;
	
	Statement state = con.createStatement();
	ResultSet rs=state.executeQuery(query);
	while(rs.next())
	{
		int question_id = rs.getInt(3);
		
	%>
	<table>
	<tr><th style="text-align:left;">Question</th></tr>
	<tr><td style="text-align:left;"><%= rs.getString(2) %></td></tr>

	<%
	String answer_query = "SELECT * FROM answers WHERE question_id=" + question_id;
	Statement state_answer = con.createStatement();
	ResultSet rs_answer = state_answer.executeQuery(answer_query);
	try{
		if(rs_answer.next()){
			%>
			<tr><th style="text-align:left;">Answer</th></tr>
			
			<tr><td style="text-align:left;"><%=rs_answer.getString(2) %></td></tr>
			</table>
			<%
		}
	}catch (Exception e){
		out.print(e);
	}
	
	%>
	
	<br>
	
	
	<%
}
	}
catch (Exception e) {
	
	
	out.print(e);
}
%>


</body>
</html>