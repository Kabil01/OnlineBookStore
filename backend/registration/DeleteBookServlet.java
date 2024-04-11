package com.uniquedeveloper.registration;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DeleteBookServlet")
public class DeleteBookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the book ID from the session
        Integer bookId = (Integer) request.getSession().getAttribute("deleteBookId");

        if (bookId != null) {
            // Database connection parameters
            String url = "jdbc:mysql://localhost:3306/BookStore?useSSL=false";
            String user = "root";
            String password = "2004";

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection(url, user, password);

                // Define a SQL query to update the visibility of the book by its ID
                String updateQuery = "UPDATE Books SET visibility = 0 WHERE id = ?";
                PreparedStatement preparedStatement = conn.prepareStatement(updateQuery);
                preparedStatement.setInt(1, bookId);

                // Execute the update query
                preparedStatement.executeUpdate();

                // Close the database connection and the prepared statement
                preparedStatement.close();
                conn.close();

                // Remove the session attribute after updating the book's visibility
                request.getSession().removeAttribute("deleteBookId");

                // Forward the request to editBook.jsp
                RequestDispatcher dispatcher = request.getRequestDispatcher("/editBook.jsp");
                dispatcher.forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
                // Handle any exceptions that occur during the update process
                // You may want to redirect the user to an error page in case of failure
                response.getWriter().write("An error occurred while updating the book's visibility.");
            }
        } else {
            // Handle the case where the book ID is not found in the session
            response.getWriter().write("Book ID not found in the session.");
        }
    }
}
