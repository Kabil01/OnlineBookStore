<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>

<%
if (request.getMethod().equalsIgnoreCase("POST")) {
    String bookImage = request.getParameter("bookImage");
    String bookName = request.getParameter("bookName");
    String author = request.getParameter("author");
    String genre = request.getParameter("genre");
    double price = Double.parseDouble(request.getParameter("price"));
    String bookLink = request.getParameter("bookLink");
    int bookId = Integer.parseInt(request.getParameter("id"));

    String url = "jdbc:mysql://localhost:3306/BookStore?useSSL=false";
    String user = "root";
    String password = "2004";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(url, user, password);

        String updateQuery = "UPDATE Books " +
                "SET image_link = ?, book_name = ?, author = ?, genre = ?, price = ?, book_file = ? " +
                "WHERE id = ?";
        PreparedStatement preparedStatement = conn.prepareStatement(updateQuery);

        preparedStatement.setString(1, bookImage);
        preparedStatement.setString(2, bookName);
        preparedStatement.setString(3, author);
        preparedStatement.setString(4, genre);
        preparedStatement.setDouble(5, price);
        preparedStatement.setString(6, bookLink);
        preparedStatement.setInt(7, bookId);

        int rowsUpdated = preparedStatement.executeUpdate();

        if (rowsUpdated > 0) {
            response.getWriter().write("success");
        } else {
            response.getWriter().write("failure");
        }

        preparedStatement.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
        response.getWriter().write("failure");
    }
}
%>
