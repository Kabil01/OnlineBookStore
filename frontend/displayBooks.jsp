<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Display Books</title>
</head>
<body>
    <h1>Book List</h1>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Book Name</th>
            <th>Author</th>
            <th>Image Link</th>
            <th>Genre</th>
            <th>Price</th>
            <th>Book File</th>
        </tr>
        <c:forEach items="${books}" var="book">
            <tr>
                <td>${book.id}</td>
                <td>${book.bookName}</td>
                <td>${book.author}</td>
                <td>${book.imageLink}</td>
                <td>${book.genre}</td>
                <td>${book.price}</td>
                <td>${book.bookFile}</td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
