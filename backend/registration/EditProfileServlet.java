package com.uniquedeveloper.registration;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/editprofile")
public class EditProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String newName = request.getParameter("name");
        String newEmail = request.getParameter("email");
        String newContact = request.getParameter("contact");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // You can retrieve the user's session data here to identify the user
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("id");

        if (newPassword.equals(confirmPassword)) {
            // Passwords match; proceed with updating the user's profile and password
            Connection con = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BookStore?useSSL=false", "root", "2004");
                PreparedStatement pst = con.prepareStatement("UPDATE Users SET uname=?, uemail=?, umobile=?, upwd=? WHERE id=?");
                pst.setString(1, newName);
                pst.setString(2, newEmail);
                pst.setString(3, newContact);
                pst.setString(4, newPassword);
                pst.setString(5, userId);

                int rowCount = pst.executeUpdate();
                // Handle the result, and maybe set some attributes for success/failure
                if (rowCount > 0) {
                    // Profile updated successfully
                    // You can set some attribute for success handling
                    response.sendRedirect("editProfile.jsp");

                } else {
                    // Failed to update the profile
                    // You can set some attribute for failure handling
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        } else {
            // Passwords don't match; you may want to handle this case accordingly
        }
    }
}
