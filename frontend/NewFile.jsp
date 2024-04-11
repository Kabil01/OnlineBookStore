<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Data Display</title>
</head>
<body>
    <h1>Data from Database</h1>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Username</th>
            <th>Password</th>
            <th>Email</th>
            <th>Mobile</th>
        </tr>
        <%
            // JDBC database connection parameters (update with your database details)
            String url = "jdbc:mysql://localhost:3306/BookStore?useSSL=false";
            String user = "root";
            String password = "2004";

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                java.sql.Connection conn = java.sql.DriverManager.getConnection(url, user, password);
                java.sql.Statement stmt = conn.createStatement();
                String sql = "SELECT * FROM Users";
                java.sql.ResultSet rs = stmt.executeQuery(sql);

                while (rs.next()) {
        %>
                    <tr>
                        <td><%= rs.getString("id") %></td>
                        <td><%= rs.getString("uname") %></td>
                        <td><%= rs.getString("upwd") %></td>
                        <td><%= rs.getString("uemail") %></td>
                        <td><%= rs.getString("umobile") %></td>
                    </tr>
        <%
                }
                rs.close();
                stmt.close();
                conn.close();
            } catch (Exception e) {
        %>
            <tr>
                <td colspan="5">Error retrieving data from the database: <%= e.getMessage() %></td>
            </tr>
        <%
            }
        %>
    </table>
</body>
</html>
