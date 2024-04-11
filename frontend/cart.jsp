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
    <title>Cart</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
    <link rel="stylesheet" type="text/css" href="css/cartstyle.css">
    <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    
    <style>
        /* The Modal (background) */
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgb(0, 0, 0);
            background-color: rgba(0, 0, 0, 0.9);
        }

        /* Modal Content/Box */
        .modal-content {
            position: relative;
            background-color: #fefefe;
            margin: 10% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            top:-20%;
            max-width: 600px;
        }

        /* Close Button */
        .close {
            position: absolute;
            top: 0;
            right: 0;
            font-size: 30px;
            font-weight: bold;
            color: #333;
            cursor: pointer;
        }

        /* Close button on hover */
        .close:hover {
            color: red;
        }
        
        .qr-img{
        	width:600px;
        
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
                <li><a href="index.jsp">Catalog</a></li>
                <li><a href="cart.jsp" style="color: #ADFF2F;text-decoration: underline;"><i class="fas fa-shopping-cart"></i> Cart</a></li>
                <li><a href="shoppingHistory.jsp"><i class="fas fa-history"></i> Shopping History</a></li>
                <li><a href="editProfile.jsp"><i class="fas fa-user-edit"></i> Edit Profile</a></li>
                <li><a href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
        </nav>
    </header>
    <div class="welcome">
        Welcome, <%= session.getAttribute("name") %>
    </div>
    <div class="main">
        <table>
            <tr>
                <th>No.</th>
                <th>Book Name</th>
                <th>Price</th>
                <th>Remove</th>
            </tr>
            <%
                String userName = (String) session.getAttribute("name");
                double totalPrice = 0.0;

                // Database connection parameters
                String url = "jdbc:mysql://localhost:3306/BookStore?useSSL=false";
                String user = "root";
                String password = "2004";

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection(url, user, password);

                    String selectQuery = "SELECT u.id AS user_id, u.uname, c.id AS cart_id, b.id AS book_id, b.book_name, b.author, b.image_link, b.genre, b.price, b.book_file " +
                            "FROM Users u " +
                            "INNER JOIN Cart c ON u.uname = c.user_name " +
                            "INNER JOIN Books b ON c.book_id = b.id " +
                            "WHERE u.uname = ? AND c.payment = 0 AND b.visibility=1"; // Only select items with payment = 0
                    PreparedStatement preparedStatement = conn.prepareStatement(selectQuery);
                    preparedStatement.setString(1, userName);

                    ResultSet rs = preparedStatement.executeQuery();

                    int index = 1;
                    while (rs.next()) {
            %>
            <tr>
                <td><%= index++ %></td>
                <td><%= rs.getString("book_name") %></td>
                <td>₹<%= rs.getDouble("price") %></td>
                <td>
                    <form action="RemoveCartItemServlet" method="post">
                        <input type="hidden" name="cartId" value="<%= rs.getInt("cart_id") %>">
                        <button type="submit">Remove</button>
                    </form>
                </td>
            </tr>
            <%
                    totalPrice += rs.getDouble("price");
                }

                // Close the database connections
                rs.close();
                preparedStatement.close();
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            session.setAttribute("totalPrice", totalPrice);
            %>
        </table>
        <p style="text-align: center;font-size:24px;">Total: ₹<%= totalPrice %></p>

        <form action="ProcessPurchaseServlet" method="post">
            <center><button type="submit" style="font-size:20px;">Purchase</button></center>
        </form>

        <!-- The Modal -->
        <div id="myModal" class="modal">
            <!-- Modal content -->
            <div class="modal-content">
                <span class="close" onclick="closeModal()">&times;</span>
                <img src="images/qr_img.jpg" alt="QR Code" id="qr-image-modal" class="qr-img">
                <div id="purchase-details-modal">
                    <p>Amount: ₹<span id="qr-amount">0.00</span></p>
                    <form action="AddTransactionServlet" method="post">
                        <input type="text" name="upiReference" placeholder="Enter UPI Reference Number" required>
                        <input type="hidden" name="totalAmount" id="total-amount-input">
                        <button type="submit">Submit</button>
                    </form>
                </div>
            </div>
        </div>

        <script>
            // JavaScript to show the modal when the "Purchase" button is clicked
            document.querySelector("form[action='ProcessPurchaseServlet']").addEventListener("submit", function (event) {
                event.preventDefault();
                // Display the modal
                document.getElementById("myModal").style.display = "block";
                // Update the QR code amount
                document.getElementById("qr-amount").textContent = <%= totalPrice %>.toFixed(2);
                // Update the hidden input field with the total amount
                document.getElementById("total-amount-input").value = <%= totalPrice %>;
            });

            // Function to close the modal
            function closeModal() {
                document.getElementById("myModal").style.display = "none";
            }
        </script>
    </div>
</body>
</html>
