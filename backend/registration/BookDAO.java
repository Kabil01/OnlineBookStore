package com.uniquedeveloper.registration;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BookDAO {
    public List<Book> getAllBooks() {
        List<Book> books = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Establish a database connection (modify the connection details)
        	conn =DriverManager.getConnection("jdbc:mysql://localhost:3306/BookStore?useSSL=false","root","2004");


            // SQL query to retrieve data from the "Books" table
            String sql = "SELECT * FROM Books";

            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Book book = new Book();
                book.setId(rs.getInt("id"));
                book.setBookName(rs.getString("book_name"));
                book.setAuthor(rs.getString("author"));
                book.setImageLink(rs.getString("image_link"));
                book.setGenre(rs.getString("genre"));
                book.setPrice(rs.getDouble("price"));
                books.add(book);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close resources (connections, statements, result sets)
        }

        return books;
    }
}
