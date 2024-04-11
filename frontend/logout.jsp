<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Invalidate the session
    session.invalidate();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="refresh" content="2;url=login.jsp">
    <title>Logout</title>
</head>
<body>
    <h1>Logout</h1>
    <p>You have been successfully logged out.</p>
    <p>Redirecting to the login page...</p>
</body>
</html>
