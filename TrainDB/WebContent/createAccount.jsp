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
	<input type="password" name="password1">
	<br>
	<br>
	<b>Confirm Password </b>
	<input type="password" name="password2">
	<br>
	<br>
	<b>Email </b>
	<input type="email" name="email">
	<br>
	<br>
	<b>First Name </b>
	<input type="text" name="first">
	<br>
	<br>
	<b>Last Name </b>
	<input type="text" name="last">
	<br>
	<br>
	<b>Phone Number </b>
	<input type="tel" name="phone" pattern="[0-9]{3}-[0-9]{3}-[0-9]{4}">
	Format: 123-456-7890
	<br>
	<br>
	<b>City </b>
	<input type="text" name="city">
	<br>
	<br>
	<b>State </b>
	<input type="text" name="state">
	<br>
	<br>
	<b>Zip </b>
	<input type="text" name="zip" pattern="[0-9]{5}">
	Format: 12345 (5 digits)
	<br>
	<br>
	
	<input type="submit" value="Create">
	</form>
<br>

</body>
</html>