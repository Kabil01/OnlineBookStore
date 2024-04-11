<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="css/sweet.css">
    <title>Transaction Result</title>
</head>
<body>
    <div class="transaction-result">
        <%
            boolean transactionResult = (boolean) request.getAttribute("transactionResult");
            String resultMessage = transactionResult ? "Transaction Successful" : "Transaction Failed";
            String iconType = transactionResult ? "success" : "error";
        %>
        <p class='<%= transactionResult ? "success-message" : "failure-message" %>'><%= resultMessage %></p>
    </div>

    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <script>
        // Display a SweetAlert notification
        swal({
            title: "Transaction Result",
            text: '<%= resultMessage %>',
            icon: '<%= iconType %>',
            button: "OK",
        }).then(function () {
            // Redirect to cart.jsp after the SweetAlert is closed
            window.location.href = 'cart.jsp';
        });
    </script>
</body>
</html>
