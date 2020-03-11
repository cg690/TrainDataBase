<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Home</title>
	</head>
<body>
<br>
	
	<%
		session.removeAttribute("username");
		session.removeAttribute("password");
		session.removeAttribute("email");
		session.removeAttribute("first");
		session.removeAttribute("last");
		session.removeAttribute("phone");
		session.removeAttribute("city");
		session.removeAttribute("state");
		session.removeAttribute("zip");
        session.invalidate();
        response.sendRedirect("index.jsp");
	 %>
<br>

</body>
</html>