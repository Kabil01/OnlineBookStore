	package com.uniquedeveloper.registration;
	
	import java.io.IOException;
	import java.sql.Connection;
	import java.sql.DriverManager;
	import java.sql.PreparedStatement;
	import java.sql.ResultSet;
	
	import javax.servlet.ServletException;
	import javax.servlet.annotation.WebServlet;
	import javax.servlet.http.HttpServlet;
	import javax.servlet.http.HttpServletRequest;
	import javax.servlet.http.HttpServletResponse;
	
	@WebServlet("/AddTransactionServlet")
	public class AddTransactionServlet extends HttpServlet {
	
		/**
		 * 
		 */
		private static final long serialVersionUID = 1L;
	
	
		protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        // Get user input from the form
	        double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));
	        String upiReference = request.getParameter("upiReference");
	
	        // Assuming you already have the user's session in which you store user information, including their name.
	        String userName = (String) request.getSession().getAttribute("name");
	
	        // Store the transaction data in your database and handle success/failure
	        boolean transactionResult = storeTransaction(userName, totalAmount, upiReference);
	
	        // Set an attribute in the request to indicate the result
	        request.setAttribute("transactionResult", transactionResult);
	
	        // Forward the request to a result page
	        request.getRequestDispatcher("transactionResult.jsp").forward(request, response);
	    }
	
		private boolean storeTransaction(String userName, double totalAmount, String upiReference) {
		    String url = "jdbc:mysql://localhost:3306/BookStore?useSSL=false";
		    String user = "root";
		    String password = "2004";

		    try {
		        Class.forName("com.mysql.cj.jdbc.Driver");
		        Connection conn = DriverManager.getConnection(url, user, password);

		        // Get the user's ID from the Users table based on their username
		        int userId = getUserIdFromUserName(userName);
		        String insertQuery = "INSERT INTO Transactions (user_id, total_amount, upi_reference,date,time) VALUES (?, ?, ?, CURDATE(),CURTIME())";
		        PreparedStatement preparedStatement = conn.prepareStatement(insertQuery);
		        preparedStatement.setInt(1, userId);
		        preparedStatement.setDouble(2, totalAmount);
		        preparedStatement.setString(3, upiReference);

		        int rowsUpdated = preparedStatement.executeUpdate();

		        // Set UPI reference where payment=0
		        String setUPISql = "UPDATE Cart SET upi = ? WHERE user_name = ? AND payment = 0";
		        PreparedStatement setUPIStatement = conn.prepareStatement(setUPISql);
		        setUPIStatement.setString(1, upiReference);
		        setUPIStatement.setString(2, userName);
		        int rowsUpdatedUPI = setUPIStatement.executeUpdate();
		        setUPIStatement.close();

		        // If UPI reference was set successfully, update payment to 1
		        if (rowsUpdatedUPI > 0) {
		            String updateQuery = "UPDATE Cart SET payment = 1 WHERE user_name = ? AND upi = ?";
		            PreparedStatement preparedStatementUpdate = conn.prepareStatement(updateQuery);
		            preparedStatementUpdate.setString(1, userName);
		            preparedStatementUpdate.setString(2, upiReference);

		            int rowsUpdateds = preparedStatementUpdate.executeUpdate();

		            if (rowsUpdateds > 0) {
		                // Transaction was added successfully
		                preparedStatementUpdate.close();
		                preparedStatement.close();
		                conn.close();
		                return true;
		            }
		            preparedStatementUpdate.close();
		        }

		        conn.close();
		        return false;
		    } catch (Exception e) {
		        e.printStackTrace();
		        return false;
		    }
		}

	
		private void updatePaymentInCart(String userName) {
		    String url = "jdbc:mysql://localhost:3306/BookStore?useSSL=false";
		    String user = "root";
		    String password = "2004";
	
		    try {
		        Class.forName("com.mysql.cj.jdbc.Driver");
		        Connection conn = DriverManager.getConnection(url, user, password);
	
		        String updateQuery = "UPDATE Cart SET payment = 1 WHERE user_name = ?";
		        PreparedStatement preparedStatement = conn.prepareStatement(updateQuery);
		        preparedStatement.setString(1, userName);
	
		        preparedStatement.executeUpdate();
	
		        preparedStatement.close();
		        conn.close();
		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		}
	
	
	    private int getUserIdFromUserName(String userName) {
	        int userId = 0;  // Initialize to a default value
	
	        String url = "jdbc:mysql://localhost:3306/BookStore?useSSL=false";
	        String user = "root";
	        String password = "2004";
	
	        try {
	            Class.forName("com.mysql.cj.jdbc.Driver");
	            Connection conn = DriverManager.getConnection(url, user, password);
	
	            String selectQuery = "SELECT id FROM Users WHERE uname = ?";
	            PreparedStatement preparedStatement = conn.prepareStatement(selectQuery);
	            preparedStatement.setString(1, userName);
	
	            // Execute the query and retrieve the user's ID
	            // (This assumes that the username is unique)
	            if (preparedStatement.execute()) {
	                ResultSet rs = preparedStatement.getResultSet();
	                if (rs.next()) {
	                    userId = rs.getInt("id");
	                }
	                rs.close();
	            }
	
	            preparedStatement.close();
	            conn.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	
	        return userId;
	    }
	}
