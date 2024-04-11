<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Book</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    
    <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            text-align: center;
        }

        form {
            background: #fff;
            max-width: 450px;
            margin: 0 auto;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        label {
            display: block;
            text-align: left;
            margin-top: 10px;
            font-weight: bold;
        }

        input[type="text"],
        input[type="number"] {
            width: 95%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        input[type="submit"] {
            background-color: #3498db;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #2980b9;
        }
    </style>
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
    <br>
    <form action="AddBookServlet" method="post">
        <label for="bookName">Book Name:</label>
        <input type="text" id="bookName" name="bookName" required><br>
        <label for="author">Author:</label>
        <input type="text" id="author" name="author" required><br>
        <label for="imageLink">Image Link:</label>
        <input type="text" id="imageLink" name="imageLink" required><br>
        <label for="genre">Genre:</label>
        <input type="text" id="genre" name="genre"required><br>
        <label for="price">Price:</label>
        <input type="number" id="price" name="price" required><br>
        <label for="bookLink">Book Link:</label>
        <input type="text" id="bookLink" name="bookLink" required><br>
        <input type="submit" value="Add Book">
    </form>
    <script>
    // Check if the status parameter exists in the URL
    const urlParams = new URLSearchParams(window.location.search);
    const status = urlParams.get("status");

    // Function to display a SweetAlert success message
    function showSuccessAlert() {
        Swal.fire({
            icon: "success",
            title: "Success!",
            text: "Book added successfully.",
            confirmButtonColor: "#3498db",
        });
    }

    // Function to display a SweetAlert error message
    function showErrorAlert() {
        Swal.fire({
            icon: "error",
            title: "Error!",
            text: "Book could not be added.",
            confirmButtonColor: "#3498db",
        });
    }

    // Check the status parameter and show the appropriate alert
    if (status === "success") {
        showSuccessAlert();
    } else if (status === "failed" || status === "error") {
        showErrorAlert();
    }
</script>
<script>
    // Function to validate the form before submission
    function validateForm() {
        const bookName = $("#bookName").val().trim();
        const author = $("#author").val().trim();
        const imageLink = $("#imageLink").val().trim();
        const price = $("#price").val().trim();
        const bookLink = $("#bookLink").val().trim();

        if (bookName === "" || author === "" || imageLink === "" || price === "" || bookLink === "") {
            // Display a SweetAlert error message
            Swal.fire({
                icon: "error",
                title: "Error!",
                text: "Please fill in all required fields.",
                confirmButtonColor: "#3498db",
            });

            return false; // Prevent form submission
        }

        return true; // Form is valid, allow submission
    }

    // Attach the validation function to the form's submit event using jQuery
    $("form").on("submit", function (event) {
        if (!validateForm()) {
            event.preventDefault(); // Prevent form submission if validation fails
        }
    });
</script>
</body>
</html>
