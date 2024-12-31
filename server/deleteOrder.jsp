<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>Delete Order</title>
    <script>
        // Close the modal and redirect after deletion
        function closeAndRedirect() {
            window.location.href = 'manageUsers.jsp';
        }
    </script>
</head>
<body>
    <%
        Connection conn = null;
        PreparedStatement deleteStmt = null;
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        try {
            // Database connection details
            String dbURL = "jdbc:mysql://localhost:3306/furniture";
            String dbUser = "root";
            String dbPassword = "root";

            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

            // Start a transaction for deleting the order (if there are related records in other tables)
            conn.setAutoCommit(false);

            // Delete related order items first
            String deleteOrderItemsSql = "DELETE FROM order_items WHERE oid = ?";
            deleteStmt = conn.prepareStatement(deleteOrderItemsSql);
            deleteStmt.setInt(1, orderId);
            deleteStmt.executeUpdate();

            // Then delete the order from the orders table
            String deleteOrderSql = "DELETE FROM orders WHERE oid = ?";
            deleteStmt = conn.prepareStatement(deleteOrderSql);
            deleteStmt.setInt(1, orderId);
            int rowsDeleted = deleteStmt.executeUpdate();

            if (rowsDeleted > 0) {
                // Commit the transaction
                conn.commit();
                out.println("<script>alert('Order deleted successfully!'); closeAndRedirect();</script>");
            } else {
                out.println("<script>alert('Error deleting the order!'); closeAndRedirect();</script>");
            }
        } catch (Exception e) {
            try {
                // In case of error, rollback the transaction
                if (conn != null) conn.rollback();
            } catch (SQLException rollbackEx) {
                e.printStackTrace();
            }
            out.println("<p class='text-red-500'>Error: " + e.getMessage() + "</p>");
        } finally {
            try {
                if (deleteStmt != null) deleteStmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                out.println("<p class='text-red-500'>Error closing resources: " + e.getMessage() + "</p>");
            }
        }
    %>
</body>
</html>
