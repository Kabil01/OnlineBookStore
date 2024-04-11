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
    <title>Shopping History</title>
<link rel="stylesheet" type="text/css" href="css/styles.css">
    <link rel="stylesheet" type="text/css" href="css/cartstyle.css">
    <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" herf="text/css" href="css/shopstyle.css">
    <script>
    // JavaScript to create a lightbox effect for images
    
</script>

    </head>
<body>
	<header>           
        <div class="logo-container">
            <a href="index.jsp"><img src="images/logo.png" alt="Logo"></a>
            <h1>DIST BOOK STORE</h1>
        </div>
        <nav class="menu" id="menu">
            <ul>
            	<li><a href="index.jsp">Catalog</a></li>
                <li><a href="cart.jsp"><i class="fas fa-shopping-cart"></i> Cart</a></li>
                <li><a href="shoppingHistory.jsp" style="color: #ADFF2F;text-decoration: underline;"><i class="fas fa-history"></i> Shopping History</a></li>
                <li><a href="editProfile.jsp"><i class="fas fa-user-edit"></i> Edit Profile</a></li>
                <li><a href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
        </nav>
    </header>
    <div class="welcome">
        Welcome, <%= session.getAttribute("name") %>
    </div>
    
    <h2><center>Shopping History</center></h2>
    <table>
        <tr>
            <th>Book Image</th>
            <th>Book Name</th>
            <th>Author</th>
            <th>Genre</th>
            <th>Download</th>
        </tr>
        <%
// Get the user's name from the session
String userName = (String) session.getAttribute("name");

// Database connection parameters
String url = "jdbc:mysql://localhost:3306/BookStore?useSSL=false";
String user = "root";
String password = "2004";

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection(url, user, password);

    String selectQuery = "SELECT b.book_name, b.author, b.genre, b.book_file, b.image_link " +
                        "FROM Cart c " +
                        "INNER JOIN Books b ON c.book_id = b.id " +
                        "WHERE c.payment = 2 AND c.user_name = ?";
    PreparedStatement preparedStatement = conn.prepareStatement(selectQuery);
    
    // Set the user name parameter in the query
    preparedStatement.setString(1, userName);

    ResultSet rs = preparedStatement.executeQuery();

    while (rs.next()) {
%>
        <tr>
            <td>
                <img src="<%= rs.getString("image_link") %>" alt="Book Image" width="100"
                     onclick="openImageModal('<%= rs.getString("image_link") %>')">
            </td>  
            <td><%= rs.getString("book_name") %></td>
            <td><%= rs.getString("author") %></td>
            <td><%= rs.getString("genre") %></td>
            <td><a href="<%= rs.getString("book_file") %>" target="_blank">Download</a></td>
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
        
    </table>
    <h1 style="background-color:red;"><center>Purchase Verification Pending</center></h1>
    <table>
        <tr>
            <th>Book Image</th>
            <th>Book Name</th>
            <th>Author</th>
            <th>Genre</th>
            <th>Purchase</th>
        </tr>
        <%
// Get the user's name from the session


try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection(url, user, password);

    String selectQuery = "SELECT b.book_name, b.author, b.genre, b.book_file, b.image_link " +
                        "FROM Cart c " +
                        "INNER JOIN Books b ON c.book_id = b.id " +
                        "WHERE c.payment = 1 AND c.user_name = ?";
    PreparedStatement preparedStatement = conn.prepareStatement(selectQuery);
    
    // Set the user name parameter in the query
    preparedStatement.setString(1, userName);

    ResultSet rs = preparedStatement.executeQuery();

    while (rs.next()) {
%>
        <tr>
            <td>
                <img src="<%= rs.getString("image_link") %>" alt="Book Image" width="100"
                     onclick="openImageModal('<%= rs.getString("image_link") %>')">
            </td>  
            <td><%= rs.getString("book_name") %></td>
            <td><%= rs.getString("author") %></td>
            <td><%= rs.getString("genre") %></td>
			<td style="background-color:red;color:white;font-weight:bolder;opacity:0.4;">PENDING</td>			
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
</table>
</body>
</html>
