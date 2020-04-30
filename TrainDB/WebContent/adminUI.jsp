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
	<form method="post" action="editInfo.jsp">
	<b>Username of Customer to edit: </b>
	<input type="text" name="username">
	<br>
	<input type="submit" value="Edit">
	</form>
<br>
	<form method="post" action="editEmployee.jsp">
	<b>SSN of employee to edit, add, or delete</b>
	<br>
	<input type="text" name="ssn" pattern="[0-9]{3}-[0-9]{2}-[0-9]{4}">
	<br>
	 (123-45-6789) Format
	
	
	<br>
	
	<input type="submit" name= "editButton" value="Edit">
	
	<input type="submit" name= "addButton" value="Add">
	
	<input type="submit" name= "deleteButton" value="Delete" >
	</form>	
	
<br>
	<form method="post" action="salesReport.jsp">
	<b>Enter month & year of to get sales </b>
	<br>
	Month:(xx)
	<input type="text" name="month" pattern="[0-9]{2}">
	<br>
	
	year:(xxxx)
		<input type="text" name="month" pattern="[0-9]{4}">
	<br>
	<input type="submit" value="Sales Report" >
	</form>
	
	
	<br>
	<form method="post" action="reservationListFeedback.jsp">
	<b>Get list of reservations By Transit line & train ID:</b>
	<br>
	Transit name: <input type="text" name="tname">
	<br>
	
	Train ID: <input type="text" name="tid">
	<br>
	<input type="submit" name = "tlist" value="List">
	<br>
		<b>Get list of reservations By Customer:</b>
	<br>
	Username: <input type="text" name="username">
	<br>
	<input type="submit" name ="clist" value="List">
	</form>
	
	<br>
	<form method="post" action="revenueFeedback.jsp">
	<b>Get the revenue generated by Transit line, city, or user</b>
	<input type="text" name="input" >
	
	<br>
	
	<input type="submit" name= "byTransit" value="By transit line">
	
	<input type="submit" name= "byCity" value="By city">
	
	<input type="submit" name= "byUser" value="By username" >
	</form>

<br>	
	<b>Get best customer and most active transit lines</b>
	<form method="post" action="bestCustomerFeedback.jsp">
	<input type="submit" value="Get">
	</form>
		<br>
		<form method="post" action="index.jsp">
	<input type="submit" value="Home">
	</form>
	
	
	

</body>
</html>
