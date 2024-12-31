<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>

<%
    String cartId = request.getParameter("cartId");

    if (cartId != null) {
        String dbURL = "jdbc:mysql://localhost:3306/furniture";
        String dbUser = "root";
        String dbPassword = "root";

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

            String sql = "DELETE FROM cart WHERE cid = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(cartId));

            int rowsDeleted = stmt.executeUpdate();

            if (rowsDeleted > 0) {
                response.sendRedirect("cart.jsp"); // Redirect back to the cart page
            } else {
                out.println("<p class='text-red-500'>Failed to remove item from cart.</p>");
            }
        } catch (Exception e) {
            out.println("<p class='text-red-500'>Error: " + e.getMessage() + "</p>");
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                out.println("<p class='text-red-500'>Error closing resources: " + e.getMessage() + "</p>");
            }
        }
    } else {
        response.sendRedirect("cart.jsp");
    }
%>
