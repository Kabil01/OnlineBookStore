package com.uniquedeveloper.registration;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;


@WebServlet("/RemoveCartItemServlet")
public class RemoveCartitemServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the cartId from the form
        int cartId = Integer.parseInt(request.getParameter("cartId"));

        // Database connection parameters
        String url = "jdbc:mysql://localhost:3306/BookStore?useSSL=false";
        String user = "root";
        String password = "2004";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, user, password);

            // Define the SQL query to remove the item from the cart
            String removeQuery = "DELETE FROM Cart WHERE id = ?";

            PreparedStatement preparedStatement = conn.prepareStatement(removeQuery);
            preparedStatement.setInt(1, cartId);

            // Execute the SQL query to remove the item
            preparedStatement.executeUpdate();

            // Close the database connections
            preparedStatement.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Redirect back to the cart page or a confirmation page
        response.sendRedirect("cart.jsp");
    }
}
