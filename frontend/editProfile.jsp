<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Edit Profile</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
    <link rel="stylesheet" type="text/css" href="css/editstyle.css">
    <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    
</head>
<body>
    <div class="main">
        <!-- Edit profile form -->
        <header>           
        <div class="logo-container">
            <a href="index.jsp"><img src="images/logo.png" alt="Logo"></a>
            <h1>DIST BOOK STORE</h1>
        </div>
        <nav class="menu" id="menu">
            <ul>
            	<li><a href="index.jsp">Catalog</a></li>
           		<li><a href="cart.jsp"><i class="fas fa-shopping-cart"></i> Cart</a></li>
		        <li><a href="shoppingHistory.jsp"><i class="fas fa-history"></i> Shopping History</a></li>
                <li><a href="editProfile.jsp" style="color: #ADFF2F;text-decoration: underline;"><i class="fas fa-user-edit"></i> Edit Profile</a></li>	
		        <li><a href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
    
            </ul>
        </nav>
    </header>
    <div class="welcome">
        Let's start learning, <%= session.getAttribute("name") %>
    </div>
        <section class="edit-profile">
        <div class="container">
            <div class="edit-profile-content">
                <div class="edit-profile-form">
                    <h2 class="form-title">Edit Profile</h2>
                    <form method="post" action="editprofile">
                        <div class="form-group">
                            <label for="name">Name:</label>
                            <input type="text" name="name" id="name" placeholder="Your Name" value="<%= session.getAttribute("name") %>" />
                        </div>
                        <div class="form-group">
                            <label for="email">Email:</label>
                            <input type="email" name="email" id="email" placeholder="Your Email" value="<%= session.getAttribute("email") %>" />
                        </div>
                        <div class="form-group">
                            <label for="contact">Contact:</label>
                            <input type="text" name="contact" id="contact" placeholder="Contact no" value="<%= session.getAttribute("contact") %>" />
                        </div>
                        <!-- Password input fields for changing the password -->
                        <div class="form-group">
                            <label for="newPassword">New Password:</label>
                            <input type="password" name="newPassword" id="newPassword" placeholder="New Password" />
                        </div>
                        <div class="form-group">
                            <label for="confirmPassword">Confirm New Password:</label>
                            <input type="password" name="confirmPassword" id="confirmPassword" placeholder="Confirm New Password" />
                        </div>
                        <div class="form-group">
                            <input type="submit" name="update" id="update" class="form-submit" value="Update" />
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </section>
    </div>
</body>
</html>
