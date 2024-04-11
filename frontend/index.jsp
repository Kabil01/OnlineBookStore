<%
    // Check if the "name" session attribute is null
    if (session.getAttribute("name") == null) {
        response.sendRedirect("login.jsp");
    } 
%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>DIST BOOKS</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
    <link rel="stylesheet" type="text/css" href="css/indexstyle.css">
    <link href="https://fonts.googleapi	s.com/css2?family=Pacifico&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    <style>
        .cart-button {
            background-color: #4caf50;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            text-decoration: none;
            cursor: pointer;
            transition: background-color 0.3s;
            font-size: 16px;
            margin-top: 10px;
        }

        .cart-button:hover {
            background-color: orange;
        }

        /* Add a cart icon */
        .cart-button i {
            margin-right: 5px;
        }

        /* Make the button stand out with a shadow */
        .cart-button:focus {
            outline: none;
            box-shadow: 0 0 10px rgba(33, 150, 243, 0.9);
        }

        .book-card h3 {
            font-size: 18px; /* Decreased font size for the book title */
            margin: 10px 0;
            color: #2c3e50; /* Darker text color */
            font-family: 'Pacifico', cursive; /* Use the 'Pacifico' font for a more stylish look */
        }

        .book-card p {
            font-size: 16px; /* Decreased font size for other information */
            margin: 5px 0;
            color: #7f8c8d; /* Slightly lighter text color */
        }

        /* Style the price with a bold font and larger font size */
        .book-card p.price {
            font-weight: bold;
            font-size: 18px; /* Larger font size for the price */
        }

        .header-container {
            display: flex;
            justify-content: space-between;
            text-align: center;
        }

        .search-container {
            text-align: center;
            margin-bottom: 10px;
        }

        /* Style for the search input and button */
        .search-container input[type=text] {
            padding: 10px;
            width: 500px; /* Adjust the width as needed */
            box-sizing: border-box; /* Include padding and border in the element's total width */
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .search-container button {
            margin-top: 10px; /* Adjust margin as needed */
            padding: 10px;
            background: #4caf50;
            color: #fff;
            border: none;
            cursor: pointer;
            border-radius: 4px;
        }

        .search-container button:hover {
            background-color: orange;
        }

        .status-message-add p{
            background-color: blue;
            color: white;
            padding: 10px;
            font-weight:bolder;
            font-size:20px;
            border-radius: 4px;
            text-align: center;
            margin-top: 10px;
        }

        .status-message-bought p{
            background-color: #3498db;
            color: white;
            font-size:20px;
            font-weight:bolder;
            padding: 10px;
            border-radius: 4px;
            text-align: center;
            margin-top: 10px;
        }
        
    </style>
</head>
<body>

<header>
    <div class="logo-container">
        <a href="index.jsp"><img src="images/logo.png" alt="Logo"></a>
        <h1>DIST BOOK STORE</h1>
    </div>
    <nav class="menu" id="menu">
        <ul>
            <li><a href="index.jsp" style="color: #ADFF2F;text-decoration: underline;"><i class="fas fa-user-edit" ></i> Catalog</a></li>
            <li><a href="cart.jsp"><i class="fas fa-shopping-cart"></i> Cart</a></li>
            <li><a href="shoppingHistory.jsp"><i class="fas fa-history"></i> Shopping History</a></li>
            <li><a href="editProfile.jsp"><i class="fas fa-user-edit"></i> Edit Profile</a></li>
            <li><a href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
        </ul>
    </nav>
</header>

<div class="main">
    <div class="header-container">
        <!-- Search container in the center -->
        <div class="search-container">
            <form method="get" action="index.jsp">
                <input type="text" placeholder="Search for books, genres, titles..." name="search">
                <button type="submit"><i class="fa fa-search"></i> Search</button>
            </form>
        </div>
        <!-- Sort By dropdown on the left -->
        <div class="sorting-dropdown">
            <form method="get" action="index.jsp">
                <label for="sort">Sort By:</label>
                <select id="sort" name="sort" onchange="this.form.submit()">
                    <option value="">Select...</option>
                    <option value="lowtohigh">Price: Low to High</option>
                    <option value="hightolow">Price: High to Low</option>
                    <option value="trending">Trending</option>
                </select>
            </form>
        </div>
    </div>

    <!-- Book grid -->
    <div class="book-grid">
        <%
    // Database connection parameters
    String url = "jdbc:mysql://localhost:3306/BookStore?useSSL=false";
    String user = "root";
    String password = "2004";

    String sortBy = request.getParameter("sort");
    String filterGenres = request.getParameter("genre");
    String searchKeyword = request.getParameter("search"); // Added search parameter

    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection(url, user, password);

    // Construct the SQL query based on sorting, filtering, and search parameters
    String sqlQuery = "SELECT * FROM Books WHERE visibility = 1";

    if (searchKeyword != null && !searchKeyword.isEmpty()) {
        sqlQuery += " AND (book_name LIKE ? OR author LIKE ? OR genre LIKE ?)";
    }

    if ("lowtohigh".equals(sortBy)) {
        sqlQuery += " ORDER BY price ASC";
    } else if ("hightolow".equals(sortBy)) {
        sqlQuery += " ORDER BY price DESC";
    } else if ("trending".equals(sortBy)) {
        sqlQuery = "SELECT b.* FROM Books b " +
                "LEFT JOIN Cart c ON b.id = c.book_id " +
                "WHERE c.payment = 2 AND b.visibility = 1 " +
                "GROUP BY b.id " +
                "ORDER BY COUNT(c.id) DESC";
    } else {
        // Default sorting: Added to Cart first, then Bought
        sqlQuery += " ORDER BY (SELECT COUNT(*) FROM Cart c WHERE c.book_id = Books.id AND c.payment = 1) , " +
                "(SELECT COUNT(*) FROM Cart c WHERE c.book_id = Books.id AND c.payment = 2) ";
    }

    PreparedStatement preparedStatement = conn.prepareStatement(sqlQuery);

    if (searchKeyword != null && !searchKeyword.isEmpty()) {
        // Set the search parameters in the prepared statement
        preparedStatement.setString(1, "%" + searchKeyword + "%");
        preparedStatement.setString(2, "%" + searchKeyword + "%");
        preparedStatement.setString(3, "%" + searchKeyword + "%");
    }

    ResultSet rs = preparedStatement.executeQuery();

    while (rs.next()) {
        // Check if the product is already in the cart
        String checkCartQuery = "SELECT * FROM Cart WHERE user_name = ? AND book_id = ?";
        PreparedStatement checkCartStatement = conn.prepareStatement(checkCartQuery);
        checkCartStatement.setString(1, (String) session.getAttribute("name"));
        checkCartStatement.setInt(2, rs.getInt("id"));
        ResultSet cartResult = checkCartStatement.executeQuery();

        boolean isInCart = cartResult.next();
        int paymentStatus = isInCart ? cartResult.getInt("payment") : 0;

        checkCartStatement.close();
        cartResult.close();
%>

<div class="book-card">
    <img src="<%= rs.getString("image_link") %>" alt="<%= rs.getString("book_name") %>">
    <h3><%= rs.getString("book_name") %></h3>
    <p>Author: <%= rs.getString("author") %></p>
    <p>Genre: <%= rs.getString("genre") %></p>
    <p class="price">Price: ₹<%= rs.getDouble("price") %></p>

            <%
                // Display status message based on payment status
                if (isInCart) {
                    if (paymentStatus == 2) {
            %>
                        <p style="color:#fff;font-size:20px;font-weight:bolder;background-color:#4285f4;">Bought</p>
            <%
                    } else if(paymentStatus==1){
            %>
                        <p style="color:#fff;font-size:20px;font-weight:bolder;background-color:#ff6666">Payment Processing</p>
            <%
                    }
                    else{
                %>
                 <p style="color:#fff;font-size:20px;font-weight:bolder;background-color:#4285f4">Added to Cart</p>
                <%  
                    	
                    }
                } else {
            %>
                 <!-- Display the "Add to Cart" button -->
        <form method="post" action="AddToCartServlet">
            <input type="hidden" name="book_id" value="<%= rs.getInt("id") %>">
            <input type="hidden" name="user_name" value="<%= session.getAttribute("name") %>">
            <button type="submit" class="cart-button">
                <i class="fas fa-cart-plus"></i> Add to Cart
            </button>
        </form>
    <%
        }
    %>
</div>

<%
    }
    rs.close();
    preparedStatement.close();
    conn.close();
%>
    </div>
</div>

</body>
</html>
