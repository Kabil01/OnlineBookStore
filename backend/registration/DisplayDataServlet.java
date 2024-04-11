package com.uniquedeveloper.registration;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DisplayDataServlet")
public class DisplayDataServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // JDBC database connection parameters (update with your database details)
        String url = "jdbc:mysql://localhost:3306/BookStore?useSSL=false";
        String user = "root";
        String password = "2004";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, user, password);
            Statement stmt = conn.createStatement();
            String sql = "SELECT * FROM Users";
            ResultSet rs = stmt.executeQuery(sql);

            // Generate HTML table
            out.println("<html><body><table border='1'><tr><th>ID</th><th>Username</th><th>Password</th><th>Email</th><th>Mobile</th></tr>");
            while (rs.next()) {
                out.println("<tr><td>" + rs.getString("id") + "</td><td>" + rs.getString("uname") + "</td><td>" + rs.getString("upwd") + "</td><td>" + rs.getString("uemail") + "</td><td>" + rs.getString("umobile") + "</td></tr>");
            }
            out.println("</table></body></html>");

            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
