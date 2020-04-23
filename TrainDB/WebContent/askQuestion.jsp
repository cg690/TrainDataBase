<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Ask a Question!</title>
</head>
<body>
<h1>Ask a question!</h1>
<br>
<p>Our Customer Representatives will answer your question in a timely manner</p>
<br>
<br>
<ul>
	
	<p>Question: </p>
	<form method="post" action="askQuestionFeedback.jsp">
	<input type="text" name="question">
	<input type="submit" value="submit">
	
	</form>
	

</ul>

<form method="get" action = "messageCustomerService.jsp">
		<input type="submit" value="Return to Customer Service">
</form>

	<br>
	<br>
</body>
</html>