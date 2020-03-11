<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Create Account</title>
	</head>
<body>
<br>


	<form method="post" action="createAccountFeedback.jsp">
	<b>Username </b>
	<input type="text" name="username">
	<br>
	<br>
	<b>Password </b>
	<input type="text" name="password1">
	<br>
	<br>
	<b>Confirm Password </b>
	<input type="text" name="password2">
	<br>
	<br>
	<input type="submit" value="Create Account">
	</form>
<br>

</body>
</html>