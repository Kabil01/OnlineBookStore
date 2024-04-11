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
    <title>Statistics</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
    
    <link rel="stylesheet" type="text/css" href="css/statisticsstyle.css">
    <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    
</head>
<body>
    <header>
        <div class="logo-container">
            <a href="index.jsp"><img src="images/logo.png" alt="Logo"></a>
            <h1>DIST BOOK STORE</h1>
        </div>
        <nav class="menu" id="menu">
            <ul>
                <li><a href="editBook.jsp"><i class="fas fa-user-edit"></i>Edit Books</a></li>
                <li><a href="checkPurchase.jsp"><i class="fas fa-shopping-cart"></i>Check Purchases</a></li>
                <li><a href="statistics.jsp"><i class="fas fa-history"></i>Statistics</a></li>
                <li><a href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
        </nav>
    </header>

    <h1><center>Book Purchase Statistics</center></h1>

    <div class="statistics">
    <%
        // JDBC database connection parameters
        String url = "jdbc:mysql://localhost:3306/BookStore?useSSL=false";
        String user = "root";
        String password = "2004";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, user, password);

            // Get the total number of books bought
            String totalBooksQuery = "SELECT COUNT(*) AS total_books FROM Transactions";
            PreparedStatement totalBooksStatement = conn.prepareStatement(totalBooksQuery);
            ResultSet totalBooksResult = totalBooksStatement.executeQuery();
            totalBooksResult.next();
            int totalBooks = totalBooksResult.getInt("total_books");
            totalBooksResult.close();
            totalBooksStatement.close();

            // Get the total amount spent
            String totalAmountQuery = "SELECT SUM(total_amount) AS total_amount FROM Transactions";
            PreparedStatement totalAmountStatement = conn.prepareStatement(totalAmountQuery);
            ResultSet totalAmountResult = totalAmountStatement.executeQuery();
            totalAmountResult.next();
            double totalAmount = totalAmountResult.getDouble("total_amount");
            totalAmountResult.close();
            totalAmountStatement.close();

            // Get the book names and their purchase counts

        %>
            <p>Total Books Sold: <%= totalBooks %></p>
            <p>Total Amount Got: Rs. <%= totalAmount %></p>
    </div>
    <%
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
</div>
<%
Class.forName("com.mysql.cj.jdbc.Driver");
Connection conn = DriverManager.getConnection(url, user, password);
    // Get the book names and their purchase counts
    String bookCountsQuery = "SELECT b.book_name, COUNT(t.book_id) AS sold_count FROM Books b LEFT JOIN Cart t ON b.id = t.book_id and payment=2 GROUP BY b.book_name ORDER BY sold_count DESC;";
    PreparedStatement bookCountsStatement = conn.prepareStatement(bookCountsQuery);
    ResultSet bookCountsResult = bookCountsStatement.executeQuery();

%>
<table>
    <tr>
        <th>Book Name</th>
        <th>Sold Orders Count</th>
    </tr>
    <%
        while (bookCountsResult.next()) {
    %>
    <tr>
        <td><%= bookCountsResult.getString("book_name") %></td>
        <td><%= bookCountsResult.getInt("sold_count") %></td>
    </tr>
    <%
        }
    %>
</table>
<%
    // Close the database connections
    bookCountsResult.close();
    bookCountsStatement.close();
%>

</body>
</html>
