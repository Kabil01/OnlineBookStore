<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Book Details</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
    <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    
    <style>
        .book-grid {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
        }

        .book-card {
            border: 1px solid #ddd;
            padding: 20px;
            margin: 20px;
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
            transition: 0.3s;
            width: 300px;
            position: relative;
        }

        .book-card:hover {
            box-shadow: 0 8px 16px 0 rgba(0, 0, 0, 0.2);
        }

        .close {
            position: absolute;
            top: 10px;
            right: 10px;
            font-size: 20px;
            cursor: pointer;
        }

        .book-image,
        .book-details,
        .book-links {
            display: flex;
            flex-direction: column;
            margin-bottom: 10px;
        }

        .book-links input {
            margin-top: 10px;
        }

        .update-button {
            text-align: center;
        }
    </style>

    <script>
    function updateBook() {
        var bookImage = document.getElementById("bookImage").value;
        var bookName = document.getElementById("bookName").value;
        var author = document.getElementById("author").value;
        var genre = document.getElementById("genre").value;
        var price = document.getElementById("price").value;
        var bookLink = document.getElementById("bookLink").value;
        var bookId = document.getElementById("bookId").value;

        var xhr = new XMLHttpRequest();
        xhr.open("POST", "updateBook.jsp", true);
        xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                var response = xhr.responseText;
                console.log("Response from server:", response); // Add this line for debugging

                if (response === "failure") {
                    swal("Error", "Failed to update book details", "error");

                } else {
                    swal("Success", "Book details updated successfully", "success").then(function () {
                        window.location.href = "editBook.jsp";
                    });
                }
            }
        };
        var data = "bookImage=" + bookImage + "&bookName=" + bookName + "&author=" + author + "&genre=" + genre + "&price=" + price + "&bookLink=" + bookLink + "&id=" + bookId;
        xhr.send(data);
    }
</script>


</head>

<body>
    <header>           
        <div class="logo-container">
            <a href="index.jsp"><img src="images/logo.png" alt="Logo"></a>
            <h1>DIST BOOK STORE</h1>
        </div>
        <nav class="menu" id="menu">
            <ul>
                <li><a href="editBook.jsp"><i class="fas fa-user-edit"></i>Edit Books</a></li>
        		<li><a href="checkPurchase.jsp"><i class="fas fa-shopping-cart"></i>Check Purchases</a></li>
		        <li><a href="statistics.jsp"><i class="fas fa-history"></i>Statistics</a></li>
		        <li><a href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
        </nav>
    </header>

    <h1><center>Edit Book Details</center></h1>

    <div class="book-grid">
        <%
            String url = "jdbc:mysql://localhost:3306/BookStore?useSSL=false";
            String user = "root";
            String password = "2004";

            int bookId = Integer.parseInt(request.getParameter("id"));

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection(url, user, password);

                String selectQuery = "SELECT * FROM Books WHERE id = ?";
                PreparedStatement preparedStatement = conn.prepareStatement(selectQuery);
                preparedStatement.setInt(1, bookId);
                ResultSet rs = preparedStatement.executeQuery();

                if (rs.next()) {
        %>
            <div class="book-card">
                <!-- <span class="close" onclick="this.parentElement.style.display='none';">&times;</span>-->
                <div class="book-image">
                    Book Image:<input type="text" id="bookImage" value="<%= rs.getString("image_link") %>">
                </div>
                <div class="book-details">
                    Book Name:<input type="text" id="bookName" value="<%= rs.getString("book_name") %>">
                    Author   :<input type="text" id="author" value="<%= rs.getString("author") %>">
                    Genre    :<input type="text" id="genre" value="<%= rs.getString("genre") %>">
                    Price    :<input type="text" id="price" value="<%= rs.getDouble("price") %>">
                </div>
                <div class="book-links">
                    Link :<input type="text" id="bookLink" value="<%= rs.getString("book_file") %>">
                    <input type="hidden" id="bookId" value="<%= bookId %>">
                </div>
            </div>
        </div>
        <div class="update-button">
            <button type="button" onclick="updateBook()">Update Book</button>
            
        </div>
        <%
                }

                rs.close();
                preparedStatement.close();
                conn.close();
                

	            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </div>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    
</body>
</html>
	