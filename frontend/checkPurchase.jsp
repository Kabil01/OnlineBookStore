<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>

<!-- Import the necessary servlet classes -->
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="javax.servlet.http.Cookie" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Check Purchases</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
    <link rel="stylesheet" type="text/css" href="css/cartstyle.css">
    <link rel="stylesheet" type="text/css" href="css/purchasestyle.css">
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
                <li><a href="checkPurchase.jsp" style="color: #ADFF2F;text-decoration: underline;"><i class="fas fa-shopping-cart"></i>Check Purchases</a></li>
                <li><a href="statistics.jsp"><i class="fas fa-history"></i>Statistics</a></li>
                <li><a href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
        </nav>
    </header>

    <!-- Unverified Purchases -->
    <h1><center>Unverified Purchases</center></h1>
    <div class="transaction-list">
        <table>
            <tr>
                <th>Transaction ID</th>
                <th>User Name</th>
                <th>Total Amount</th>
                <th>UPI Reference</th>
                <th>Verification Status</th>
                <th>Action</th>
            </tr>

            <%
                String url = "jdbc:mysql://localhost:3306/BookStore?useSSL=false";
                String user = "root";
                String password = "2004";

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection(url, user, password);

                    String selectQuery = "SELECT T.id, U.uname, T.total_amount, T.upi_reference, T.verified " +
                            "FROM Transactions T " +
                            "INNER JOIN Users U ON T.user_id = U.id " +
                            "WHERE T.verified = 0 ORDER BY T.date, T.time";
                    PreparedStatement preparedStatement = conn.prepareStatement(selectQuery);
                    ResultSet rs = preparedStatement.executeQuery();

                    while (rs.next()) {
            %>
                <tr>
                    <td><%= rs.getInt("id") %></td>
                    <td><%= rs.getString("uname") %></td>
                    <td><%= rs.getDouble("total_amount") %></td>
                    <td><%= rs.getString("upi_reference") %></td>
                    <td style="background-color:red;color:white;font-weight:bolder;opacity:0.7;">Pending</td>
                    <td>
                        <form method="post" action="checkPurchase.jsp">
                            <input type="hidden" name="transactionId" value="<%= rs.getInt("id") %>">
                            <input type="hidden" name="userName" value="<%= rs.getString("uname") %>">
                            
                            <select name="action">
                                <option value="accept">Accept</option>
                                <option value="reject">Reject</option>
                            </select>
                            <input type="submit" value="Submit">
                        </form>
                    </td>
                </tr>
            <%
                    }

                    rs.close();
                    preparedStatement.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </table>
    </div>

    <!-- Verified Purchases -->
    <h1><center>Verified Purchases</center></h1>
    <div class="transaction-list">
        <table>
            <tr>
                <th>Transaction ID</th>
                <th>User ID</th>
                <th>Total Amount</th>
                <th>UPI Reference</th>
                <th>Verification Status</th>
            </tr>

            <%
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection(url, user, password);

                    String selectQuery = "SELECT T.id, U.uname, T.total_amount, T.upi_reference, T.verified " +
                            "FROM Transactions T " +
                            "INNER JOIN Users U ON T.user_id = U.id " +
                            "WHERE T.verified = 1 ORDER BY T.date, T.time";
                    PreparedStatement preparedStatement = conn.prepareStatement(selectQuery);
                    ResultSet rs = preparedStatement.executeQuery();

                    while (rs.next()) {
            %>
                <tr>
                    <td><%= rs.getInt("id") %></td>
                    <td><%= rs.getString("uname") %></td>
                    <td><%= rs.getDouble("total_amount") %></td>
                    <td><%= rs.getString("upi_reference") %></td>
                    <td style="background-color:green;color:white;font-weight:bolder;opacity:0.7;">Accepted</td>
                </tr>
            <%
                    }

                    rs.close();
                    preparedStatement.close();
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </table>
    </div>
    <h1><center>Rejected Purchases</center></h1>
    <div class="transaction-list">
        <table>
            <tr>
                <th>Transaction ID</th>
                <th>User ID</th>
                <th>Total Amount</th>
                <th>UPI Reference</th>
                <th>Verification Status</th>
            </tr>

            <%
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection(url, user, password);

                    String selectQuery = "SELECT T.id, U.uname, T.total_amount, T.upi_reference, T.verified " +
                            "FROM Transactions T " +
                            "INNER JOIN Users U ON T.user_id = U.id " +
                            "WHERE T.verified = -1 ORDER BY T.date, T.time";
                    PreparedStatement preparedStatement = conn.prepareStatement(selectQuery);
                    ResultSet rs = preparedStatement.executeQuery();

                    while (rs.next()) {
            %>
                <tr>
                    <td><%= rs.getInt("id") %></td>
                    <td><%= rs.getString("uname") %></td>
                    <td><%= rs.getDouble("total_amount") %></td>
                    <td><%= rs.getString("upi_reference") %></td>
                    <td style="background-color:red;color:white;font-weight:bolder;">Rejected</td>
                </tr>
            <%
                    }

                    rs.close();
                    preparedStatement.close();
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </table>
    </div>

	<% 
    if (request.getMethod().equalsIgnoreCase("POST")) {
        int transactionId = Integer.parseInt(request.getParameter("transactionId"));
        String action = request.getParameter("action");
        int verified = 0;

        if (action.equals("accept")) {
            verified = 1;

            try {
                // Establish database connection
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection(url, user, password);

                // Update the Transactions table
                String updateTransactionsQuery = "UPDATE Transactions SET verified = ? WHERE id = ?";
                PreparedStatement updateTransactionsStatement = conn.prepareStatement(updateTransactionsQuery);
                updateTransactionsStatement.setInt(1, verified);
                updateTransactionsStatement.setInt(2, transactionId);

                int rowsUpdated = updateTransactionsStatement.executeUpdate();

                updateTransactionsStatement.close();

                // If the purchase is accepted, get the UPI reference from the Transactions table
                String getUpiReferenceQuery = "SELECT upi_reference FROM Transactions WHERE id = ?";
                PreparedStatement getUpiReferenceStatement = conn.prepareStatement(getUpiReferenceQuery);
                getUpiReferenceStatement.setInt(1, transactionId);
                ResultSet upiReferenceResultSet = getUpiReferenceStatement.executeQuery();

                if (upiReferenceResultSet.next()) {
                    String upiReference = upiReferenceResultSet.getString("upi_reference");

                    // Update the payment status in the Cart table for the corresponding UPI reference
                    String updateCartQuery = "UPDATE Cart SET payment = 2 WHERE upi = ?";
                    PreparedStatement updateCartStatement = conn.prepareStatement(updateCartQuery);
                    updateCartStatement.setString(1, upiReference);

                    int rowsUpdatedInCart = updateCartStatement.executeUpdate();

                    updateCartStatement.close();
                }

                upiReferenceResultSet.close();
                getUpiReferenceStatement.close();
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }

            // Redirect to the same page to refresh the data
            response.sendRedirect("checkPurchase.jsp");
        } else {
            verified = -1;

            try {
                // Establish database connection
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection(url, user, password);

                // Update the Transactions table
                String updateTransactionsQuery = "UPDATE Transactions SET verified = ? WHERE id = ?";
                PreparedStatement updateTransactionsStatement = conn.prepareStatement(updateTransactionsQuery);
                updateTransactionsStatement.setInt(1, verified);
                updateTransactionsStatement.setInt(2, transactionId);

                int rowsUpdated = updateTransactionsStatement.executeUpdate();

                updateTransactionsStatement.close();

                // If the purchase is rejected, update the Cart table
                if (verified == -1) {
                    String upiReference = request.getParameter("upiReference");

                    // Update the payment status in the Cart table for the corresponding UPI reference
                    String updateCartQuery = "UPDATE Cart SET payment = -1 WHERE upi = ?";
                    PreparedStatement updateCartStatement = conn.prepareStatement(updateCartQuery);
                    updateCartStatement.setString(1, upiReference);

                    int rowsUpdatedInCart = updateCartStatement.executeUpdate();

                    updateCartStatement.close();
                }

                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }

            // Redirect to the same page to refresh the data
            response.sendRedirect("checkPurchase.jsp");
        }
    }
    %>
</body>
</html>
