<!DOCTYPE html>
<html>
<head>
    <title>Admin Login</title>
    <link rel="stylesheet" href="fonts/material-icon/css/material-design-iconic-font.min.css">
    <style>
   header {
    background-color: #232f3e; /* A pleasant blue color */
    color: #fff; /* White text color */
    padding: 20px 0; /* Increased padding for spacing */
    display: flex;
    justify-content: space-between;
    align-items: center;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2); /* Drop shadow for a modern look */
}

.logo-container {
    display: flex;
    align-items: center;
    /*margin-left: -300px;*/ /* Adjust the margin for spacing */
}

.logo-container img {
    width: 100px; /* Adjust the size as needed */
    height: 100px; /* Adjust the size as needed */
    transition: transform 0.2s ease, filter 0.2s ease;
    padding:10px;
    /*margin-left:-150px;*/
}

.logo-container img:hover {
    transform: scale(1.1);
    filter: brightness(1.2);
}
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            text-align: center;
        }
        
        form {
            background: #fff;
            max-width: 300px;
            margin: 0 auto;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        
        label {
            display: block;
            text-align: left;
            margin-top: 10px;
        }
        
        input[type="text"],
        input[type="password"] {
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
    <h1>Admin Login&nbsp;	 </h1>&nbsp;
    </header>
    <br>
    <form method="post" action="adminLogin">
    	<br>
        <label for="name">Admin Name:</label>
        <input type="text" name="name" id="name" required><br>
        <label for="password">Password:</label>
        <input type="password" name="password" id="password" required><br>
        <input type="submit" value="Login">
    </form>
</body>
</html>
