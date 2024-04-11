<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Books</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
        <link rel="stylesheet" type="text/css" href="css/cartstyle.css">
    
    <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
	<header>           
        <div class="logo-container">
            <a href="index.jsp"><img src="images/logo.png" alt="Logo"></a>
            <h1><center>DIST BOOK STORE</center></h1>
        </div>
        <nav class="menu" id="menu">
            <ul>
                <li><a href="editBook.jsp" style="color: #ADFF2F;text-decoration: underline;"><i class="fas fa-user-edit"></i>Edit Books</a></li>
        		<li><a href="checkPurchase.jsp"><i class="fas fa-shopping-cart"></i>Check Purchases</a></li>
		        <li><a href="statistics.jsp"><i class="fas fa-history"></i>Statistics</a></li>
		        <li><a href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
        </nav>
    </header>
    <h1>Edit Books</h1>
    <table>
        <tr>
            <th>Book ID</th>
            <th>Book Name</th>
            <th>Author</th>
            <th>Genre</th>
            <th>Edit</th>
            <th>Delete</th>
        </tr>
        <%
            // Database connection parameters
            String url = "jdbc:mysql://localhost:3306/BookStore?useSSL=false";
            String user = "root";
            String password = "2004";

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection(url, user, password);

                String selectQuery = "SELECT * FROM Books where visibility=1";
                PreparedStatement preparedStatement = conn.prepareStatement(selectQuery);
                ResultSet rs = preparedStatement.executeQuery();

                while (rs.next()) {
        %>
                <tr>	
                    <td><%= rs.getInt("id") %></td>
                    <td><%= rs.getString("book_name") %></td>
                    <td><%= rs.getString("author") %></td>
                    <td><%= rs.getString("genre") %></td>
                    <td><a href="editBookDetails.jsp?id=<%= rs.getInt("id") %>">Edit</a></td>
                    <td>
					    <%
					        int bookId = rs.getInt("id");
					        session.setAttribute("deleteBookId", bookId);
					    %>
					    <form action="DeleteBookServlet" method="post">
					        <input type="hidden" name="bookId" value="<%= bookId %>">
					        <button type="submit">Delete</button>
					    </form>
					</td>


                </tr>
        <%
                }

                // Close the database connections
                rs.close();
                preparedStatement.close();
                conn.close();
                
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
        <!-- End of book listing -->
    </table>
    <!-- Add any other content or navigation here -->
</body>
</html>
