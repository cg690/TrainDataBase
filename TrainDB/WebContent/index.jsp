<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Train DB</title>
	</head>
<body>
<br>
	<form method="post" action="login.jsp">
	<b>Username </b>
	<input type="text" name="username">
	<br>
	<br>
	<b>Password </b>
	<input type="text" name="password">
	<br>
	<br>
	<input type="submit" value="Login">
	</form>
	
	<br>
	<br>
	<form method="post" action="createAccount.jsp">
	<input type="submit" value="Create Account">
	</form>
<br>

</body>
</html>