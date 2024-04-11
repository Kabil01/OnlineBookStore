package com.uniquedeveloper.registration;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @SuppressWarnings("resource")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookId = Integer.parseInt(request.getParameter("book_id"));
        String userName = (String) request.getSession().getAttribute("name"); // Get the username from the session

        // JDBC database connection parameters
        String url = "jdbc:mysql://localhost:3306/BookStore?useSSL=false";
        String user = "root";
        String password = "2004";

        Connection conn = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, password);

            // Check if the book is already in the cart for the user
            String checkQuery = "SELECT * FROM Cart WHERE book_id = ? AND user_name = ?";
            preparedStatement = conn.prepareStatement(checkQuery);
            preparedStatement.setInt(1, bookId);
            preparedStatement.setString(2, userName);

            resultSet = preparedStatement.executeQuery();

            if (!resultSet.next()) {
                // If the book is not already in the cart, insert it
                String insertQuery = "INSERT INTO Cart (book_id, user_name) VALUES (?, ?)";
                preparedStatement = conn.prepareStatement(insertQuery);
                preparedStatement.setInt(1, bookId);
                preparedStatement.setString(2, userName);

                preparedStatement.executeUpdate();
            } else {
                // If the book is already in the cart, display a SweetAlert message
                response.setContentType("text/html");
                response.getWriter().write("<script>alert('Book is already in your cart.');</script>");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            // Handle any exceptions, e.g., display an error message or redirect to an error page
        } finally {
            // Close resources
            if (resultSet != null) {
                try {
                    resultSet.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (preparedStatement != null) {
                try {
                    preparedStatement.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }

        // After adding to the cart or displaying the message, you can redirect to the index page or a confirmation page
        response.sendRedirect("index.jsp");
    }
}
