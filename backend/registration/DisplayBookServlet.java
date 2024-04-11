package com.uniquedeveloper.registration;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//Import statements

@WebServlet("/displayBooks")
public class DisplayBookServlet extends HttpServlet {
 /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
     try {
         // Establish a database connection
         Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/yourdb", "username", "password");

         // Create a SQL query to retrieve data
         String sql = "SELECT * FROM Books";

         // Create a PreparedStatement
         PreparedStatement preparedStatement = conn.prepareStatement(sql);

         // Execute the query
         ResultSet resultSet = preparedStatement.executeQuery();

         // Store the result in a List or other data structure
         List<Book> books = new ArrayList<Book>();
         while (resultSet.next()) {
             Book book = new Book();
             book.setId(resultSet.getInt("id"));
             book.setBookName(resultSet.getString("book_name"));
             book.setAuthor(resultSet.getString("author"));
             book.setImageLink(resultSet.getString("image_link"));
             book.setGenre(resultSet.getString("genre"));
             book.setPrice(resultSet.getDouble("price"));
             book.setBookFile(resultSet.getString("book_file"));
             books.add(book);
         }

         // Close database connections
         resultSet.close();
         preparedStatement.close();
         conn.close();

         // Set the data in a request attribute
         request.setAttribute("books", books);

         // Forward the request to the JSP for display
         RequestDispatcher dispatcher = request.getRequestDispatcher("displayBooks.jsp");
         dispatcher.forward(request, response);
     } catch (SQLException e) {
         e.printStackTrace();
     }
 }
}
