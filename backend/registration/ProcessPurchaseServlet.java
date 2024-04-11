package com.uniquedeveloper.registration;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DecimalFormat;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ProcessPurchaseServlet")
public class ProcessPurchaseServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve the total price from the user's session
        double totalPrice = (Double) request.getSession().getAttribute("totalPrice");

        // Retrieve the user's name from the session
        String userName = (String) request.getSession().getAttribute("name");

        // Display the total amount in the response
        response.setContentType("text/html");
        response.getWriter().print("<h2>Amount: $" + new DecimalFormat("0.00").format(totalPrice) + "</h2>");

        // You can optionally provide a static QR code image URL
        response.getWriter().print("<img src='path_to_your_qr_code_image.png' alt='QR Code'>");

        // Store the transaction data in your database
        storeTransaction(userName, totalPrice);
    }

    private void storeTransaction(String userName, double totalPrice) {
        String url = "jdbc:mysql://localhost:3306/BookStore?useSSL=false";
        String user = "root";
        String password = "2004";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, user, password);

            // Get the user's ID from the Users table based on their username
            int userId = getUserIdFromUserName(userName);

            String insertQuery = "INSERT INTO Transactions (user_id, total_amount, upi_reference) VALUES (?, ?, ?)";
            PreparedStatement preparedStatement = conn.prepareStatement(insertQuery);
            preparedStatement.setInt(1, userId);
            preparedStatement.setDouble(2, totalPrice);
            preparedStatement.setString(3, "ReplaceWithActualUPIReference");  // Replace with the actual UPI reference.

            preparedStatement.executeUpdate();

            preparedStatement.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private int getUserIdFromUserName(String userName) {
        int userId = 0;  // Initialize to a default value

        String url = "jdbc:mysql://localhost:3306/BookStore?useSSL=false";
        String user = "root";
        String password = "2004";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, user, password);

            String selectQuery = "SELECT id FROM Users WHERE uname = ?";
            PreparedStatement preparedStatement = conn.prepareStatement(selectQuery);
            preparedStatement.setString(1, userName);

            ResultSet rs = preparedStatement.executeQuery();

            if (rs.next()) {
                userId = rs.getInt("id");
            }

            rs.close();
            preparedStatement.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return userId;
    }
}
