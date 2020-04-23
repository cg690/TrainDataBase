<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.traindb.pk.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>NJ-Transit</title>
</head>
<body>
<h1>Search Questions and Answers</h1>

<br>
<br>


<p>Search Questions:</p>
<form method="post" action="searchQuestions.jsp">
	<input type="text" name="search">
	<input type="submit" value="submit">
</form>
<%
String myText = request.getParameter("search");
if(myText != null){
	
	//search is the question
	StringBuilder name_sb = new StringBuilder();
	name_sb.append('\'');
	String user = session.getAttribute("username").toString();
	name_sb.append(user);
	name_sb.append('\'');
	ApplicationDB app = new ApplicationDB();
	Connection con = app.getConnection();
	StringBuilder sb = new StringBuilder();
	sb.append('\'');
	sb.append(myText);
	sb.append('\'');
	String finalQuestion = sb.toString();
	
	
	String query = "SELECT * FROM questions WHERE questions.question=" + finalQuestion + "AND questions.username=" + name_sb.toString();
	
	Statement state = con.createStatement();
	ResultSet rs=state.executeQuery(query);
	if(rs.next()){
		%>
		<table>
		<tr><th style="text-align:left;">Question</th></tr>
		<tr><td style="text-align:left;"><%= rs.getString("question") %></td></tr>
		<%
		//now we need to go digging in answers for this
		String answer_query = "SELECT * FROM answers WHERE question_id=" + rs.getInt("question_id");
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
	}else if(rs.next() == false){
		out.println("Question could not be found");
	}
}

//now we need to search the questions database for this question


%>

<br>
<br>
<form method="get" action = "messageCustomerService.jsp">
		<input type="submit" value="Return to Customer Service">
</form>
</body>
</html>