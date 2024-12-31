<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Order Status</title>
</head>
<body>
    <%
        Connection conn = null;
        PreparedStatement updateStmt = null;
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String status = request.getParameter("status");

        try {
            // Database connection details
            String dbURL = "jdbc:mysql://localhost:3306/furniture";
            String dbUser = "root";
            String dbPassword = "root";

            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

            // Update the status of the order
            String updateSql = "UPDATE orders SET status = ? WHERE oid = ?";
            updateStmt = conn.prepareStatement(updateSql);
            updateStmt.setString(1, status);
            updateStmt.setInt(2, orderId);

            int rowsUpdated = updateStmt.executeUpdate();
            if (rowsUpdated > 0) {
                // Set a message in the request scope to display the alert in manageUsers.jsp
                request.setAttribute("updateMessage", "Order status updated successfully!");
                // Forward the request to manageUsers.jsp
                request.getRequestDispatcher("manageUsers.jsp").forward(request, response);
            } else {
                out.println("<p>Error updating order status.</p>");
            }
        } catch (Exception e) {
            out.println("<p class='text-red-500'>Error: " + e.getMessage() + "</p>");
        } finally {
            try {
                if (updateStmt != null) updateStmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                out.println("<p class='text-red-500'>Error closing resources: " + e.getMessage() + "</p>");
            }
        }
    %>
</body>
</html>
