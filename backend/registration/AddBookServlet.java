package com.uniquedeveloper.registration;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AddBookServlet")
public class AddBookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve book information from the form
        String bookName = request.getParameter("bookName");
        String author = request.getParameter("author");
        String imageLink = request.getParameter("imageLink");
        String genre = request.getParameter("genre");
        double price = Double.parseDouble(request.getParameter("price"));
        String bookLink = request.getParameter("bookLink");

        // Database connection parameters
        String url = "jdbc:mysql://localhost:3306/BookStore?useSSL=false";
        String user = "root";
        String password = "2004";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, user, password);

            // Define an SQL query to insert the book into the database
            String insertQuery = "INSERT INTO Books (book_name, author, image_link, genre, price, book_file, visibility) VALUES (?, ?, ?, ?, ?, ?, 1)";
            PreparedStatement preparedStatement = conn.prepareStatement(insertQuery);
            preparedStatement.setString(1, bookName);
            preparedStatement.setString(2, author);
            preparedStatement.setString(3, imageLink);
            preparedStatement.setString(4, genre);
            preparedStatement.setDouble(5, price);
            preparedStatement.setString(6, bookLink);

            int rowCount = preparedStatement.executeUpdate();

            if (rowCount > 0) {
                // Insertion was successful
                response.sendRedirect("addbook.jsp?status=success");
            } else {
                // Insertion failed
                response.sendRedirect("addbook.jsp?status=failed");
            }

            // Close the database connection and the prepared statement
            preparedStatement.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            // Handle any exceptions that occur during the insertion process
            // You may want to redirect the user to an error page in case of failure
            response.sendRedirect("addbook.jsp?status=error");
        }
    }
}
