package com.uniquedeveloper.registration;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/adminLogin")
public class AdminLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name"); // Corrected parameter name
        String password = request.getParameter("password"); // Corrected parameter name
        HttpSession session = request.getSession();
        RequestDispatcher dispatcher = null;
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BookStore?useSSL=false", "root", "2004");
            PreparedStatement pst = con.prepareStatement("select * from admin where name = ? and password = ?");
            pst.setString(1, name);
            pst.setString(2, password);
            ResultSet rs = pst.executeQuery();
            
            if (rs.next()) {
                session.setAttribute("adminName", rs.getString("name")); // You can set any attribute you need
                dispatcher = request.getRequestDispatcher("addbook.jsp");
            } else {
                request.setAttribute("status", "failed");
                dispatcher = request.getRequestDispatcher("admin.jsp");
            }
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
