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
<h1>View Customer Queries here</h1>

<form method="get" action = "employeePage.jsp">
		<input type="submit" value="Return Home">
</form>
<br>	

<h2>Unanswered Questions</h2>
<table border="1">
<tr>
<th>Question ID</th>
<th>Question</th>
</tr>
<%
try{
	ApplicationDB app = new ApplicationDB();
	Connection con = app.getConnection();
	String query = "SELECT username ,question_id, question FROM questions WHERE question_id NOT IN (SELECT question_id FROM answers)";
	
	Statement state = con.createStatement();
	ResultSet rs=state.executeQuery(query);
	while(rs.next())
	{
		int question_id = rs.getInt(2);
		
	%>
	<tr>
	<td><%= question_id%></td>
	<td><%= rs.getString(3) %></td>
	</tr>
		
	<%
}
	
	}
catch (Exception e) {
	
	
	out.print(e);
}
%>
	</table>

	<form method="post" action="answerQuestion.jsp">
	<h2>Type the question id of the question you'd like to answer and your reply (Part VI)</h2>
	<br>
	<label>Question ID:</label>
	<input type="number" name="question_id" >
	<br>
	 <p>Numbers only</p>
	<br>
	<label>Reply</label>
	<input type="text" name="ans">
	<input type="submit" name= "replyQuestion" value="reply" >
	</form>



</body>
</html>