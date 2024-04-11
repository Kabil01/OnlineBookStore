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

@WebServlet("/BookListServlet")
public class BookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        try {
            // JDBC database connection parameters
            String url = "jdbc:mysql://localhost:3306/BookStore?useSSL=false";
            String user = "root";
            String password = "2004";

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, user, password);

            String selectQuery = "SELECT * FROM Books";
            PreparedStatement preparedStatement = conn.prepareStatement(selectQuery);

            ResultSet rs = preparedStatement.executeQuery();

            // Generate HTML for the book grid
            StringBuilder htmlBuilder = new StringBuilder();
            while (rs.next()) {
                htmlBuilder.append("<div class='book-card'>");
                htmlBuilder.append("<img src='" + rs.getString("image_link") + "' alt='" + rs.getString("book_name") + "'>");
                htmlBuilder.append("<h3>" + rs.getString("book_name") + "</h3>");
                htmlBuilder.append("<p>Author: " + rs.getString("author") + "</p>");
                htmlBuilder.append("<p>Genre: " + rs.getString("genre") + "</p>");
                htmlBuilder.append("<p>Price: $" + rs.getDouble("price") + "</p>");
                htmlBuilder.append("<a href='" + rs.getString("book_file") + "'>Download</a>");
                htmlBuilder.append("</div>");
            }

            rs.close();
            preparedStatement.close();
            conn.close();

            request.setAttribute("bookList", htmlBuilder.toString());

            request.getRequestDispatcher("books.jsp").forward(request, response);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.getWriter().write("Error: Unable to retrieve books.");
        }
    }
}
